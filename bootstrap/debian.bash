#!/usr/bin/env bash
sudo apt-get update

# Make sure packages are installed over https
sudo apt-get install -y apt-transport-https

sudo apt-get install -y \
    lsb-release \
    python3 \
    python3-pip

# use python3 as the default
pip3 install --user --upgrade 'pip>=20.0'
# use dependency resolution
pip3 config set global.use-feature 2020-resolver
# update the packages used in the install process
pip3 install --user --upgrade setuptools wheel
# force the shell to forget all remembered locations
hash -r
# Make sure ansible is using python3
pip3 install --user --upgrade 'ansible>=2.10.0,<3.0.0'
# TODO: figure out how to deal with the fact that debian ships with broken python
# make sure all dependencies are satisfied
# pip3 check
