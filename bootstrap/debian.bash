#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo apt-get update

# Make sure packages are installed over https
sudo apt-get install -y apt-transport-https

sudo apt-get install -y \
    pipx \
    python3 \
    python3-pip

# Setup ansible
"${SCRIPT_DIR}/install_ansible.bash"

VERSION_ID="$(. /etc/os-release && echo "${VERSION_ID}")"
# make sure all dependencies are satisfied
case "${VERSION_ID}" in
    12)
        # 12 ships with a broken python and no clear way to fix it
        if [[ -n "${CI:-}" ]] && ! pip3 check; then
            # TODO: remove the v12 override
            exit 1
        fi
    ;;
    *)
        pip3 check
    ;;
esac
