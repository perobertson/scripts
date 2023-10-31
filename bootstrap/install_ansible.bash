#!/usr/bin/env bash
set -euo pipefail

# use python3 as the default
pip3 install --user --upgrade 'pip>=23.0'
# force the shell to forget all remembered locations
hash -r
# update the packages used in the install process
pip3 install --user --upgrade setuptools wheel
# Remove old ansible base package if it is installed
pip3 uninstall -y ansible-base
# Make sure ansible is using python3
pip3 install --user --upgrade 'ansible>=8.0.0,<9.0.0'
