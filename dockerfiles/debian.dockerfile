ARG OS_VERSION
FROM debian:${OS_VERSION}-slim

RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        systemd \
    && echo '%sudo  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci \
    && useradd \
        --user-group \
        --create-home \
        --groups=sudo \
        --shell=/bin/bash \
        public

# Systemd must run as root when the system boots
# This means USER cannot be set
