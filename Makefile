.DEFAULT_GOAL:=ansible-lint

.PHONY: ansible-lint
ansible-lint:
	ANSIBLE_CONFIG="./config/ansible.cfg" ansible-lint -p setup.yml systemd.yml

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
		archlinux/base:latest bash || true
	docker exec scripts-arch ./.gitlab/setup_archlinux.sh
	docker exec scripts-arch ./.gitlab/build.sh
	docker exec scripts-arch ./.gitlab/check_versions.sh
	$(MAKE) stop-arch

.PHONY: stop-arch
stop-arch:
	docker stop scripts-arch

.PHONY: fedora
fedora:
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-fedora \
		fedora:32 bash || true
	docker exec scripts-fedora ./.gitlab/setup_fedora.sh
	docker exec scripts-fedora ./.gitlab/build.sh
	$(MAKE) stop-fedora

.PHONY: stop-fedora
stop-fedora:
	docker stop scripts-fedora
