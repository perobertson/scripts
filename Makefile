.DEFAULT_GOAL:=ansible-lint
MAKEFLAGS=--warn-undefined-variables

plays:=docker gcloud kubernetes razer setup
playbooks:=$(addsuffix .yml, $(plays))
kaniko_img:=gcr.io/kaniko-project/executor:v1.7.0-debug

export ANSIBLE_CONFIG="./config/ansible.cfg"

ifneq ("$(shell command -v podman)", "")
CONTAINER?=podman
else ifneq ("$(shell command -v docker)", "")
CONTAINER?=docker
else
$(warning no container platform found. Cannot run test targets.)
endif

.git/hooks/pre-commit: .pre-commit-config.yaml
	pre-commit install

define build_image
	@# $1 is the OS
	@# $2 is the OS_VERSION
	$(CONTAINER) run \
		--entrypoint='' \
		--name="scripts-build-$(1)-$(2)" \
		--rm \
		-v "$(shell pwd):/worksapce" \
		-w /worksapce \
		$(kaniko_img) \
		./.gitlab/build_image.sh $(1) $(2)
	$(CONTAINER) load -i dockerfiles/dist/$(1)/$(1)-$(2).tar
endef

dockerfiles/dist/archlinux/archlinux-latest.tar: ./.gitlab/build_image.sh
dockerfiles/dist/archlinux/archlinux-latest.tar: dockerfiles/archlinux.dockerfile
	$(call build_image,archlinux,latest)

dockerfiles/dist/centos/centos-stream8.tar: ./.gitlab/build_image.sh
dockerfiles/dist/centos/centos-stream8.tar: dockerfiles/centos.dockerfile
	$(call build_image,centos,stream8)

dockerfiles/dist/centos/centos-stream9.tar: ./.gitlab/build_image.sh
dockerfiles/dist/centos/centos-stream9.tar: dockerfiles/centos.dockerfile
	$(call build_image,centos,stream9)

dockerfiles/dist/debian/debian-10.tar: ./.gitlab/build_image.sh
dockerfiles/dist/debian/debian-10.tar: dockerfiles/debian.dockerfile
	$(call build_image,debian,10)

dockerfiles/dist/debian/debian-11.tar: ./.gitlab/build_image.sh
dockerfiles/dist/debian/debian-11.tar: dockerfiles/debian.dockerfile
	$(call build_image,debian,11)

dockerfiles/dist/fedora/fedora-34.tar: ./.gitlab/build_image.sh
dockerfiles/dist/fedora/fedora-34.tar: dockerfiles/fedora.dockerfile
	$(call build_image,fedora,34)

dockerfiles/dist/fedora/fedora-35.tar: ./.gitlab/build_image.sh
dockerfiles/dist/fedora/fedora-35.tar: dockerfiles/fedora.dockerfile
	$(call build_image,fedora,35)

dockerfiles/dist/manjarolinux/manjarolinux-latest.tar: ./.gitlab/build_image.sh
dockerfiles/dist/manjarolinux/manjarolinux-latest.tar: dockerfiles/manjarolinux.dockerfile
	$(call build_image,manjarolinux,latest)

.PHONY: ansible-lint
ansible-lint:
	ansible-playbook --syntax-check $(playbooks)
	ansible-lint -p .

.PHONY: git_hooks
git_hooks: .git/hooks/pre-commit

.PHONY: install
install:
	./setup.sh

.PHONY: install_docker
install_docker:
	ansible-playbook --ask-become-pass -v docker.yml

.PHONY: install_flatpaks
install_flatpaks:
	ansible-playbook -v flatpaks.yml

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

define test_os
	@# $1 is the OS
	@# $2 is the OS_VERSION
	@# TODO: rustup executes files in /tmp. Needed to drop noexec
	$(CONTAINER) create \
		--env ANSIBLE_FORCE_COLOR=1 \
		--interactive \
		--name="scripts-$(1)-$(2)" \
		--rm \
		--tmpfs="/run:rw,noexec,nosuid,nodev" \
		--tmpfs="/tmp:rw,nosuid,nodev" \
		--tty \
		--volume="/sys/fs/cgroup:/sys/fs/cgroup:ro" \
		--volume="$(shell pwd):/scripts" \
		--workdir /scripts \
		"localhost/scripts-$(1):$(2)" /lib/systemd/systemd || true
	$(CONTAINER) start "scripts-$(1)-$(2)" || true
	@# The container must run as root for systemd
	@# This means we need to explicitly start a different session for the user
	$(CONTAINER) exec "scripts-$(1)-$(2)" su public --command="./setup.sh"
	$(CONTAINER) exec "scripts-$(1)-$(2)" su public --command="./.gitlab/check_versions.bash"
	$(CONTAINER) exec "scripts-$(1)-$(2)" su public --command="./.gitlab/verify_no_changes.sh"
	$(CONTAINER) stop "scripts-$(1)-$(2)"
endef

.PHONY: test-archlinux-latest
test-archlinux-latest: dockerfiles/dist/archlinux/archlinux-latest.tar
	$(call test_os,archlinux,latest)

.PHONY: test-centos-stream8
test-centos-stream8: dockerfiles/dist/centos/centos-stream8.tar
	$(call test_os,centos,stream8)

.PHONY: test-centos-stream9
test-centos-stream9: dockerfiles/dist/centos/centos-stream9.tar
	$(call test_os,centos,stream9)

.PHONY: test-debian-10
test-debian-10: dockerfiles/dist/debian/debian-10.tar
	$(call test_os,debian,10)

.PHONY: test-debian-11
test-debian-11: dockerfiles/dist/debian/debian-11.tar
	$(call test_os,debian,11)

.PHONY: test-fedora-34
test-fedora-34: dockerfiles/dist/fedora/fedora-34.tar
	$(call test_os,fedora,34)

.PHONY: test-fedora-35
test-fedora-35: dockerfiles/dist/fedora/fedora-35.tar
	$(call test_os,fedora,35)

.PHONY: test-manjarolinux-latest
test-manjarolinux-latest: dockerfiles/dist/manjarolinux/manjarolinux-latest.tar
	$(call test_os,manjarolinux,latest)

.PHONY: test-ubuntu-18
test-ubuntu-18:
	$(CONTAINER) pull ubuntu:18.04
	$(CONTAINER) run \
		-ditv "$(shell pwd):/scripts" \
		-w /scripts \
		-e ANSIBLE_FORCE_COLOR=1 \
		--rm \
		--name scripts-ubuntu-18 \
		ubuntu:18.04 /sbin/init || true
	$(CONTAINER) exec scripts-ubuntu-18 ./.gitlab/setup_ubuntu.bash
	$(CONTAINER) exec scripts-ubuntu-18 ./.gitlab/build.bash
	$(CONTAINER) exec scripts-ubuntu-18 su public --command="./.gitlab/check_versions.bash"
	$(MAKE) stop-ubuntu-18

.PHONY: stop-ubuntu-18
stop-ubuntu-18:
	$(CONTAINER) stop scripts-ubuntu-18
