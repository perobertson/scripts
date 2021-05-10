#!/usr/bin/env bash
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
    ansible \
    python \
    python-pip \
    python-setuptools \
    python-wheel

# use dependency resolution
pip config set global.use-feature 2020-resolver
# make sure all dependencies are satisfied
pip check
