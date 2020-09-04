#!/usr/bin/env bash
sudo dnf -y install \
    python3-pip

# use python3 as the default
pip3 install --user --upgrade pip
# update the packages used in the install process
pip3 install --user --upgrade setuptools wheel
# force the shell to forget all remembered locations
hash -r
# Make sure ansible is using python3
pip3 install --user --upgrade ansible
# make sure all dependencies are satisfied
pip3 check
