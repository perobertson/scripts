#!/usr/bin/env bash
sudo dnf -y install \
    python3-devel \
    python3-dnf \
    python3-pip

# use python3 as the default
pip3 install --user --upgrade pip
# use dependency resolution
pip3 config set global.use-feature 2020-resolver
# update the packages used in the install process
pip3 install --user --upgrade setuptools wheel
# force the shell to forget all remembered locations
hash -r
# Make sure ansible is using python3
pip3 install --user --upgrade 'ansible>=2.10.0,<3.0.0'
# make sure all dependencies are satisfied
pip3 check
