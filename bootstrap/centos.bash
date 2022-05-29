#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo dnf -y install \
    python3-dnf

if [[ "$(source /etc/os-release && echo "$VERSION_ID")" = "8" ]]; then
    sudo dnf -y install \
        python39-devel \
        python39-pip
else
    sudo dnf -y install \
        python3-devel \
        python3-pip
fi

# required to install dependencies of ansible
sudo dnf -y install \
    gcc \
    libffi-devel

# Setup ansible
"${SCRIPT_DIR}/install_ansible.bash"

# make sure all dependencies are satisfied
pip3 check
