#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo apt-get update

# Make sure packages are installed over https
sudo apt-get install -y apt-transport-https

sudo apt-get install -y \
    python3 \
    python3-pip

# Setup ansible
"${SCRIPT_DIR}/install_ansible.bash"

# make sure all dependencies are satisfied
pip3 check
