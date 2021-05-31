#!/usr/bin/env bash
# Will be empty when piped into bash
# Otherwise it will be the path that was invoked
CMD="${BASH_SOURCE[0]}"

if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null; then
    # Bash 4.4, Zsh
    # e: Exit on non 0 exit codes
    # u: Check for undeclared variables
    # o pipefail: Fail if any exit code in a pipeline is a fail
    set -euo pipefail
else
    # Bash 4.3 and older chokes on empty arrays with set -u.
    set -eo pipefail
fi
# null the glob when nothing matches
shopt -s nullglob

# enable recursive globbing
shopt -s globstar

# Set the PATH here since this may be the first time the script is run
# The install of the dotfiles will make it permanent
PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:${HOME}/bin:$PATH"

install_ssh_keyscan(){
    # Check if ssh-keyscan needs installed
    if [[ ! -x "$(command -v ssh-keyscan)" ]]; then
        if [[ -x "$(command -v dnf)" ]]; then
            sudo dnf install -y openssh-clients
        elif [[ -x "$(command -v apt-get)" ]]; then
            sudo apt-get update
            sudo apt-get install -y apt-transport-https
            sudo apt-get install -y openssh-client
        elif [[ -x "$(command -v pacman)" ]]; then
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm openssh
        else
            echo "WARNING: could not locate ssh-keyscan" >&2
        fi
    fi
}

install_git(){
    # Check if git needs installed
    if [[ ! -x "$(command -v git)" ]]; then
        if [[ -x "$(command -v dnf)" ]]; then
            sudo dnf install -y git
        elif [[ -x "$(command -v apt-get)" ]]; then
            sudo apt-get update
            # There was a bug in apt that allowed insecure transport
            sudo apt-get install -y apt-transport-https
            sudo apt-get install -y git
        elif [[ -x "$(command -v pacman)" ]]; then
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm git
        else
            echo "WARNING: could not locate git" >&2
        fi
    fi
}

keyscan(){
    # Setup ssh
    if [[ ! -d "${HOME}/.ssh" ]]; then
        mkdir "${HOME}/.ssh"
        chmod 700 "${HOME}/.ssh"
    fi
    touch "$HOME/.ssh/known_hosts"
    if [[ "$(grep ^gitlab.com "${HOME}/.ssh/known_hosts")" = '' ]]; then
        install_ssh_keyscan
        ssh-keyscan -v 'gitlab.com' >> "${HOME}/.ssh/known_hosts" 2>/dev/null
    fi
    if [[ "$(grep ^github.com "${HOME}/.ssh/known_hosts")" = '' ]]; then
        install_ssh_keyscan
        ssh-keyscan -v 'github.com' >> "${HOME}/.ssh/known_hosts" 2>/dev/null
    fi
}

fetch_scripts(){
    # Fetch the scripts
    if [[ ! -d "${HOME}/Applications/scripts" ]]; then
        git clone https://gitlab.com/perobertson/scripts.git \
            "${HOME}/Applications/scripts"
    elif [[ -z "${CMD:-}" ]]; then
        # user reran the curl command
        cd "${HOME}/Applications/scripts"
        git pull --rebase --stat
        cd -
    fi
}

switch_dir(){
    # Possible playbook locations:
    # - ${HOME}/Applications/scripts
    # - current directory
    if [[ -z "${CMD:-}" ]]; then
        # piped into bash, so use the fetched location
        cd "${HOME}/Applications/scripts"
    else
        # otherwise it was invoked from a shell
        HERE="$( cd "$( dirname "${CMD}" )" >/dev/null 2>&1 && pwd )"
        cd "${HERE}"
    fi
}

bootstrap(){
    os="$(. /etc/os-release && echo "${ID}")"
    case "${os}" in
        arch)    source "bootstrap/arch.bash"    ;;
        debian)  source "bootstrap/debian.bash"  ;;
        fedora)  source "bootstrap/fedora.bash"  ;;
        manjaro) source "bootstrap/manjaro.bash" ;;
        ubuntu)  source "bootstrap/ubuntu.bash"  ;;
        *)
            echo "WARNING: ${os} is not supported" >&2
            echo "Please submit an issue at https://gitlab.com/perobertson/scripts/issues" >&2
            echo "Attempting to run ansible-playbook anyways..." >&2
        ;;
    esac
}

# Clear any previous sudo permission
sudo -k

# Prevent running as root
# The intent is to update the users configs, not the system
if [[ $(id -u) -eq 0 ]]; then
    echo 'ERROR: This script must be run as a normal user.' >&2
    exit 1
fi

# Set up app directories
mkdir -pv \
    "${HOME}/Applications" \
    "${HOME}/Downloads" \
    "${HOME}/bin" \
    "${HOME}/workspace"

install_git
keyscan # TODO: is this needed?
fetch_scripts
switch_dir
bootstrap

# Run the setup
ANSIBLE_CONFIG="./config/ansible.cfg" ansible-playbook -v setup.yml

if [[ -n "${CI:-}" ]]; then
    # Additional playbooks that were originally part of setup
    ANSIBLE_CONFIG="./config/ansible.cfg" ansible-playbook -v docker.yml
    ANSIBLE_CONFIG="./config/ansible.cfg" ansible-playbook -v gcloud.yml
    ANSIBLE_CONFIG="./config/ansible.cfg" ansible-playbook -v kubernetes.yml
    ANSIBLE_CONFIG="./config/ansible.cfg" ansible-playbook -v razer.yml
fi

echo ''
echo 'Everything installed. Be sure to reboot at your earliest convenience'
