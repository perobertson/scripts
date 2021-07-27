#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
    python \
    python-pip \
    python-setuptools \
    python-wheel

if [[ -n ${CI:-} ]] && pip3 check; then
    # The error was:
    # tomli 1.0.4 requires flit-core, which is not installed
    echo 'No longer need to manually install flit-core'
    exit 1
fi
sudo pacman -S --noconfirm \
    python-flit-core

# Setup ansible
"${SCRIPT_DIR}/install_ansible.bash"

# make sure all dependencies are satisfied
pip3 check
