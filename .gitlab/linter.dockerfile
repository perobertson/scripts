FROM docker.io/python:3.10-slim

RUN apt-get update && apt-get install -y \
        bash \
        make \
    && useradd \
        --user-group \
        --create-home \
        --shell=/bin/bash \
        linter

USER linter
WORKDIR /home/linter
ENV PATH="/home/linter/.local/bin:${PATH}"

COPY --chown=linter:linter bootstrap/install_ansible.bash /tmp
RUN /tmp/install_ansible.bash \
    && pip3 install --user --upgrade \
        ansible-lint \
        yamllint \
    && ansible-lint --version \
    && yamllint --version \
    && rm /tmp/install_ansible.bash
