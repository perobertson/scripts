#!/usr/bin/env bash
set -xeuo pipefail

whoami
echo "$HOME"
pwd
ls -laH
dnf install -y sudo
echo '%wheel  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci
useradd --user-group --create-home --groups=wheel --shell=/bin/bash public
cat /etc/passwd
cat /etc/group
