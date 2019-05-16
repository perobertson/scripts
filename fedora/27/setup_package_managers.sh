#!/usr/bin/env bash

# Install RPM Fusion - Free & Non-Free
sudo dnf -y install \
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Allows for managing repos fromo cli
sudo dnf -y install dnf-plugins-core

# Add VirtualBox Repo
sudo dnf config-manager --add-repo https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

# Configure pip formatting
mkdir -p "$HOME/.config/pip"
cat > "$HOME/.config/pip/pip.conf" <<EOF
[list]
format=columns
EOF

# Sublime Text Repo
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

# Docker Repo
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
# Updates are released monthly instead of quarterly
sudo dnf config-manager --set-enabled docker-ce-edge

# MySQL repo
sudo dnf install -y "https://dev.mysql.com/get/mysql80-community-release-fc$(. /etc/os-release && echo "$VERSION_ID")-1.noarch.rpm"

# Kubernetes repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF