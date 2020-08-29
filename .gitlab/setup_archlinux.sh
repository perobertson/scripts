#!/usr/bin/env bash
set -xeuo pipefail

whoami
echo "$HOME"
pwd
ls -laH
pacman -Syu --noconfirm
pacman -S --noconfirm sudo
echo '%wheel  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci
useradd --user-group --create-home --groups=wheel --shell=/bin/bash public
cat /etc/passwd
cat /etc/group
