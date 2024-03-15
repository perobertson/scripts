#!/usr/bin/env bash
set -euo pipefail

pipx install --force --include-deps ansible
pipx upgrade ansible
# needed for: community.general.dconf
pipx inject ansible psutil
ansible --version
