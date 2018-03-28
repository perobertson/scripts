#!/usr/bin/env bash

# Display Commands
set -x

# Clear any previous sudo permission
sudo -k

# Check if we are in a CI environment
if [ -z "$CI" ]; then
  # Check for root
  [[ $(id -u) -eq 0 ]] && echo 'script must be run as a normal user' && exit 1

  # Enable 'bash strict mode' from here on out
  set -euo pipefail
fi

# Set up app directories
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/workspace"

# Check if git needs installed
if [ ! -x "$(command -v git)" ]; then
  if [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y git
  else
    sudo apt-get update
    sudo apt-get install -y git
  fi
fi

# Setup ssh
if [ ! -d "$HOME/.ssh" ]; then
  mkdir "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi
if [ "$(cat ~/.ssh/known_hosts | grep ^gitlab.com)" = '' ]; then
  ssh-keyscan 'gitlab.com' >> "$HOME/.ssh/known_hosts" 2>/dev/null
fi
if [ "$(cat ~/.ssh/known_hosts | grep ^github.com)" = '' ]; then
  ssh-keyscan 'github.com' >> "$HOME/.ssh/known_hosts" 2>/dev/null
fi

# Fetch the latest version of the setup
if [ ! -d "$HOME/workspace/scripts" ]; then
  git clone https://gitlab.com/perobertson/scripts.git "$HOME/workspace/scripts"
  cd "$HOME/workspace/scripts"
fi

# Run the setup
os=$(. /etc/os-release && echo $ID)
version=$(. /etc/os-release && echo $VERSION_ID)
if [ ! -d "${os}/${version}" ]; then
  # Use the latest setup if there is no specific setup for the OS version
  version='latest'
fi

. "${os}/${version}/setup_package_managers.sh"
. "${os}/${version}/setup_dev_depends.sh"
. "${os}/${version}/setup_databases.sh"
. "${os}/${version}/setup_ides.sh"
. "${os}/${version}/setup_virtualization.sh"

# These do not require root
. "${os}/${version}/setup_ruby.sh"
. "${os}/${version}/setup_dotfiles.sh"
. "${os}/${version}/user_settings.sh"

echo -e '\nEverything installed. Be sure to reboot at your earliest convenience'
echo 'Remember to manually install guest additions from the CD if needed after reboot'
