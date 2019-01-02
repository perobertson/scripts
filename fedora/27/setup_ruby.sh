#!/usr/bin/env bash

# Install rbenv
git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv"
cd "$HOME/.rbenv" && src/configure && make -C src && cd - || exit 1
git clone https://github.com/rbenv/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
