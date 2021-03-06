.DEFAULT_GOAL:=ansible-lint
plays:=docker gcloud kubernetes razer setup
playbooks:=$(addsuffix .yml, $(plays))

export ANSIBLE_CONFIG="./config/ansible.cfg"

.PHONY: ansible-lint
ansible-lint:
	ansible-playbook --syntax-check $(playbooks)
	ansible-lint -p $(playbooks)

.PHONY: install
install:
	./setup.sh

.PHONY: install_docker
install_docker:
	ansible-playbook --ask-become-pass -v docker.yml

.PHONY: install_gcloud
install_gcloud:
	ansible-playbook --ask-become-pass -v gcloud.yml

.PHONY: install_kubernetes
install_kubernetes:
	ansible-playbook --ask-become-pass -v kubernetes.yml

.PHONY: install_razer
install_razer:
	ansible-playbook --ask-become-pass -v razer.yml

.PHONY: install_rust_crates
install_rust_crates:
	./extras.sh

.PHONY: install_setup
install_setup:
	ansible-playbook --ask-become-pass -v setup.yml

.PHONY: install_hooks
install_hooks:
	pre-commit install

.PHONY: hooks
hooks:
	pre-commit run --all-files

.PHONY: arch
arch:
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-arch \
		archlinux:latest bash || true
	docker exec scripts-arch ./.gitlab/setup_archlinux.bash
	docker exec scripts-arch ./.gitlab/build.bash
	docker exec scripts-arch ./.gitlab/check_versions.bash
	$(MAKE) stop-arch

.PHONY: stop-arch
stop-arch:
	docker stop scripts-arch

.PHONY: debian
debian:
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-debian \
		debian:10 bash || true
	docker exec scripts-debian ./.gitlab/setup_debian.bash
	docker exec scripts-debian ./.gitlab/build.bash
	docker exec scripts-debian ./.gitlab/check_versions.bash
	$(MAKE) stop-debian

.PHONY: stop-debian
stop-debian:
	docker stop scripts-debian

.PHONY: fedora
fedora:
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-fedora \
		fedora:32 bash || true
	docker exec scripts-fedora ./.gitlab/setup_fedora.bash
	docker exec scripts-fedora ./.gitlab/build.bash
	$(MAKE) stop-fedora

.PHONY: stop-fedora
stop-fedora:
	docker stop scripts-fedora
