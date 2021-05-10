#!/usr/bin/env bash
set -xeuo pipefail

whoami
echo "$HOME"
pwd
ls -laH
pacman -Syu --noconfirm
pacman -S --noconfirm sudo
echo '%wheel  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci
if ! getent group public; then
    useradd --user-group --create-home --groups=wheel --shell=/bin/bash public
fi
cat /etc/passwd
cat /etc/group
