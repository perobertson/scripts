#!/usr/bin/env bash

set -x

# Install RPM Fusion - Free & Non-Free
sudo dnf -y install --nogpgcheck \
  http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Allows for managing repos fromo cli
sudo dnf -y install dnf-plugins-core

# VirtualBox repo
sudo dnf config-manager --add-repo http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
