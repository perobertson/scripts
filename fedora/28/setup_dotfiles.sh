#!/usr/bin/env bash

# Set up dotfiles
git clone https://gitlab.com/perobertson/dotfiles.git "$HOME/workspace/dotfiles"
"$HOME/workspace/dotfiles/install.py"
