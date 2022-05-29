ARG OS_VERSION
FROM quay.io/centos/centos:${OS_VERSION}

RUN dnf install -y \
        sudo \
        systemd \
        util-linux \
    && echo '%wheel  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci \
    && useradd \
        --user-group \
        --create-home \
        --groups=wheel \
        --shell=/bin/bash \
        public

# Systemd must run as root when the system boots
# This means USER cannot be set
