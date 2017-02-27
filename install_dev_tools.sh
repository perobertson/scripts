#!/usr/bin/env bash

set -e
set -x

sudo dnf -y upgrade vim-minimal
sudo dnf -y install autoconf \
                    make automake \
                    gcc gcc-c++ \
                    libyaml-devel \
                    libffi-devel \
                    readline-devel \
                    zlib-devel \
                    openssl-devel \
                    libtool \
                    bison \
                    patch \
                    sqlite-devel \
                    vim \
                    i3 \
                    zsh \
                    git \
                    wget \
                    ImageMagick \
                    graphviz \
                    samba \
                    redis \
                    sl \
                    p7zip bzip2 \
                    postgresql postgresql-server postgresql-contrib postgresql-devel \
                    levien-inconsolata-fonts \
                    freetype-freeworld \
                    dropbox pygpgme \
                    redhat-lsb
