.DEFAULT_GOAL:=ansible-lint

playbooks:=docker.yml gcloud.yml kubernetes.yml razer.yml setup.yml systemd.yml

.PHONY: ansible-lint
ansible-lint: export ANSIBLE_CONFIG="./config/ansible.cfg"
ansible-lint:
	ansible-playbook --syntax-check $(playbooks)
	ansible-lint -p $(playbooks)

.PHONY: install_hooks
install_hooks:
	pre-commit install

.PHONY: install
install:
	./setup.sh

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
