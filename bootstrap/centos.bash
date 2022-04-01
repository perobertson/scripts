#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo dnf -y install \
    python3-dnf \
    python39-devel \
    python39-pip

# required to install dependencies of ansible
sudo dnf -y install \
    gcc \
    libffi-devel

# Setup ansible
"${SCRIPT_DIR}/install_ansible.bash"

# make sure all dependencies are satisfied
pip3 check
