#!/usr/bin/env bash
set -xeuo pipefail

whoami
echo "$HOME"
pwd
ls -laH
apt-get update
apt-get install -y curl sudo
echo '%sudo  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci
useradd --user-group --create-home --groups=sudo --shell=/bin/bash public
cat /etc/passwd
cat /etc/group
