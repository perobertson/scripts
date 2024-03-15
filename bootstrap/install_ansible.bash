#!/usr/bin/env bash
set -euo pipefail

pipx install --force --include-deps ansible
pipx upgrade ansible
ansible --version
