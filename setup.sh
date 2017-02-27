#!/usr/bin/env bash

# Display Commands
set -x

# Clear any previous sudo permission
sudo -k

# Check for root
[[ $(id -u) -eq 0 ]] && echo 'script must be run as a normal user' && exit 1

# Set up app directories
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/workspace"

if [ -x /usr/bin/dnf ]; then
  sudo dnf install -y git
else
  sudo apt-get install -y git
fi

if [ -d "$HOME/workspace/scripts" ]; then
  cd "$HOME/workspace/scripts"
else
  ssh-keyscan >> "$HOME/.ssh/known_hosts" 2>/dev/null
  git clone https://gitlab.com/perobertson/scripts.git "$HOME/workspace/scripts"
  cd "$HOME/workspace/scripts"
fi

pwd

./install_heroku.sh
./dnf_config.sh
