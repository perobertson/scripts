#!/usr/bin/env bash
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
    ansible \
    python \
    python-pip \
    python-setuptools \
    python-wheel
