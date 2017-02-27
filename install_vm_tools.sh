#!/usr/bin/env bash

set -x

# Package to help determine if running in a VM
sudo dnf -y install virt-what

if [[ $(sudo virt-what | grep virtualbox) != '' ]]; then
  sudo dnf -y install dkms \
                      make \
                      automake \
                      gcc \
                      gcc-c++ \
                      kernel-devel-$(uname -r) \
                      akmod-VirtualBox
else
  echo "Not Implemented"
  exit 1
fi
