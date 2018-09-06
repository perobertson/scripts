#!/usr/bin/env bash

# Set up dotfiles
git clone https://gitlab.com/perobertson/dotfiles.git "$HOME/workspace/dotfiles"
cd "$HOME/workspace/dotfiles" || exit 1
rake --tasks
rake install
cd - || exit 1
