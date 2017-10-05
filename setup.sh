#!/usr/bin/env bash

# Display Commands
set -x

if [ ! -z "$CI" ]; then
  dnf install -y sudo
fi

# Clear any previous sudo permission
sudo -k

# Check for root
if [ -z "$CI" ]; then
  [[ $(id -u) -eq 0 ]] && echo 'script must be run as a normal user' && exit 1
fi

# Set up app directories
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/workspace"

# Check if git needs installed
if ! hash git 2>/dev/null; then
  if hash dnf 2>/dev/null; then
    sudo dnf install -y git
  else
    sudo apt update
    sudo apt install -y git
  fi
fi

# Fetch the latest version of the setup
if [ -d "$HOME/workspace/scripts" ]; then
  cd "$HOME/workspace/scripts"
  git pull
else
  if [ ! -d "$HOME/.ssh" ]; then
    mkdir "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
  fi
  ssh-keyscan 'gitlab.com' >> "$HOME/.ssh/known_hosts" 2>/dev/null
  ssh-keyscan 'github.com' >> "$HOME/.ssh/known_hosts" 2>/dev/null
  git clone https://gitlab.com/perobertson/scripts.git "$HOME/workspace/scripts"
  cd "$HOME/workspace/scripts"
fi

# Run the setup
os=$(. /etc/os-release && echo $ID)
. "${os}/setup_package_managers.sh" || exit 1
. "${os}/setup_dev_depends.sh" || exit 1
. "${os}/setup_databases.sh" || exit 1
. "${os}/setup_ides.sh" || exit 1
. "${os}/setup_virtualization.sh" || exit 1

# These do not require root
. "${os}/setup_ruby.sh" || exit 1
. "${os}/setup_dotfiles.sh" || exit 1
. "${os}/user_settings.sh" || exit 1

echo -e '\nEverything installed. Be sure to reboot at your earliest convenience'
echo 'Remember to manually install guest additions from the CD if needed after reboot'
