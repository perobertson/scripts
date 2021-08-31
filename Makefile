.DEFAULT_GOAL:=ansible-lint
plays:=docker gcloud kubernetes razer setup
playbooks:=$(addsuffix .yml, $(plays))

export ANSIBLE_CONFIG="./config/ansible.cfg"

.PHONY: ansible-lint
ansible-lint:
	ansible-playbook --syntax-check $(playbooks)
	ansible-lint -p .

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

.PHONY: test-arch
test-arch:
	docker pull archlinux:latest
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-arch \
		archlinux:latest bash || true
	docker exec scripts-arch ./.gitlab/setup_archlinux.bash
	docker exec scripts-arch ./.gitlab/build.bash
	docker exec scripts-arch su public --command="./.gitlab/check_versions.bash"
	$(MAKE) stop-arch

.PHONY: stop-arch
stop-arch:
	docker stop scripts-arch

.PHONY: test-debian
test-debian:
	docker pull debian:10
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-debian \
		debian:10 bash || true
	docker exec scripts-debian ./.gitlab/setup_debian.bash
	docker exec scripts-debian ./.gitlab/build.bash
	docker exec scripts-debian su public --command="./.gitlab/check_versions.bash"
	$(MAKE) stop-debian

.PHONY: stop-debian
stop-debian:
	docker stop scripts-debian

.PHONY: test-fedora
test-fedora:
	docker pull fedora:35
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-fedora \
		fedora:35 bash || true
	docker exec scripts-fedora ./.gitlab/setup_fedora.bash
	docker exec scripts-fedora ./.gitlab/build.bash
	docker exec scripts-fedora su public --command="./.gitlab/check_versions.bash"
	$(MAKE) stop-fedora

.PHONY: stop-fedora
stop-fedora:
	docker stop scripts-fedora

.PHONY: test-manjaro
test-manjaro:
	docker pull manjarolinux/base:latest
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-manjaro \
		manjarolinux/base:latest bash || true
	docker exec scripts-manjaro ./.gitlab/setup_archlinux.bash
	docker exec scripts-manjaro ./.gitlab/build.bash
	docker exec scripts-manjaro su public --command="./.gitlab/check_versions.bash"
	$(MAKE) stop-manjaro

.PHONY: stop-manjaro
stop-manjaro:
	docker stop scripts-manjaro

.PHONY: test-ubuntu-18
test-ubuntu-18:
	docker pull ubuntu:18.04
	docker run \
		-ditv $(shell pwd):/scripts \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-ubuntu-18 \
		ubuntu:18.04 bash || true
	docker exec scripts-ubuntu-18 ./.gitlab/setup_ubuntu.bash
	docker exec scripts-ubuntu-18 ./.gitlab/build.bash
	docker exec scripts-ubuntu-18 su public --command="./.gitlab/check_versions.bash"
	$(MAKE) stop-ubuntu-18

.PHONY: stop-ubuntu-18
stop-ubuntu-18:
	docker stop scripts-ubuntu-18
