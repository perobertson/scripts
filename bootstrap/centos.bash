#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo dnf -y install \
    python3-dnf \
    python3-devel \
    python3-pip

# use python3 as the default
pip3 install --user --upgrade 'pip'
# force the shell to forget all remembered locations
hash -r
# update the packages used in the install process
pip3 install --user --upgrade setuptools wheel
# install pipx
pip3 install --user --upgrade pipx

# Setup ansible
"${SCRIPT_DIR}/install_ansible.bash"

# make sure all dependencies are satisfied
pip3 check
