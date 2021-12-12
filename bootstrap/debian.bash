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

install_cairo(){
    if [[ -n ${CI:-} ]] && pip3 check; then
        # one of ansibles dependencies requires pycairo to be installed
        echo 'No longer need to manually install python3-cairo'
        exit 1
    fi
    sudo apt-get install -y python3-cairo
}

VERSION_ID="$(. /etc/os-release && echo "${VERSION_ID}")"
case "${VERSION_ID}" in
        11)
        ;;
        *)
            install_cairo
        ;;
esac

# make sure all dependencies are satisfied
pip3 check
