ARG OS_VERSION
FROM quay.io/centos/centos:${OS_VERSION}

RUN dnf install -y \
        sudo \
        util-linux \
    && echo '%wheel  ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ci \
    && useradd \
        --user-group \
        --create-home \
        --groups=wheel \
        --shell=/bin/bash \
        public

USER public
