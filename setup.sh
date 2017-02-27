#!/usr/bin/env bash

# Attempt to exit on errors
set -e

# Display Commands
# set -x

# Clear any previous sudo permission
sudo -k

# Check for root
[[ $(id -u) -eq 0 ]] && echo 'script must be run as a normal user' && exit 1

# Set up app directories
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/workspace"


echo $0

# which dnf > /dev/null 2&>1
# if [ $? -eq 0 ]; then
#   sudo dnf install -y git
# else
#   sudo apt-get install -y git
# fi

# git clone git@gitlab.com:perobertson/scripts.git "$HOME/workspace/scripts"
