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
.DEFAULT_GOAL:=lint
