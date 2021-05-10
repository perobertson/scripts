#!/usr/bin/env bash
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
    python \
    python-pip \
    python-setuptools \
    python-wheel

# use python3 as the default
pip3 install --user --upgrade 'pip>=21.0'
# update the packages used in the install process
pip3 install --user --upgrade setuptools wheel
# force the shell to forget all remembered locations
hash -r
# Make sure ansible is using python3
pip3 install --user --upgrade 'ansible>=3.0.0,<4.0.0'
# make sure all dependencies are satisfied
pip3 check
