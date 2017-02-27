#!/usr/bin/env bash

# Run this script by doing:
# /usr/bin/curl -sSL __FILE__ | bash

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
