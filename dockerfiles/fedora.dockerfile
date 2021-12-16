ARG OS_VERSION
FROM quay.io/fedora/fedora:${OS_VERSION}

RUN dnf install -y \
        shadow-utils \
        sudo \
        systemd \
    && echo '%wheel  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci \
    && /usr/sbin/useradd \
        --user-group \
        --create-home \
        --groups=wheel \
        --shell=/bin/bash \
        public

# Systemd must run as root when the system boots
# This means USER cannot be set
