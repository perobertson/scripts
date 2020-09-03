.DEFAULT_GOAL:=lint

.PHONY: lint
lint:
	ansible-lint -p setup.yml systemd.yml

.PHONY: arch
arch:
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-arch \
		archlinux/base:latest bash
	docker exec scripts-arch ./.gitlab/setup_archlinux.sh
	docker exec scripts-arch ./.gitlab/build.sh
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
