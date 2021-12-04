ARG OS_VERSION
FROM archlinux:${OS_VERSION}

RUN \
    # system upgrade \
    pacman -Syu --noconfirm \
    # install packages
    && pacman -S --noconfirm sudo \
    # create public user and add them to sudo
    && echo '%wheel  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci \
    && useradd \
        --user-group \
        --create-home \
        --groups=wheel \
        --shell=/bin/bash \
        public

# Systemd must run as root when the system boots
# This means USER cannot be set
