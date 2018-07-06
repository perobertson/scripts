#!/usr/bin/env bash

# Set up dotfiles
git clone https://gitlab.com/perobertson/dotfiles.git "$HOME/workspace/dotfiles"
cd "$HOME/workspace/dotfiles" &&
    rake install[true] &&
    cd - || exit 1
