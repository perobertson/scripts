#!/usr/bin/env bash

set -x

# Package to help determine if running in a VM
sudo dnf -y install virt-what

if [[ $(sudo virt-what | grep virtualbox) != '' ]]; then
  sudo dnf -y install dkms \
                      kernel-devel-$(uname -r)
  # Guest additions must be manually installed after each kernel update
else
  sudo dnf -y install virt-manager \
                      libvirt \
                      qemu \
                      qemu-kvm
  sudo dnf -y install binutils \
                      gcc \
                      make \
                      patch \
                      libgomp \
                      glibc-headers glibc-devel \
                      kernel-headers kernel-headers-$(uname -r) \
                      kernel-devel-$(uname -r) \
                      dkms
  sudo dnf -y install VirtualBox-5.1
  sudo usermod -a -G vboxusers $(whoami)
fi
