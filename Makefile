.DEFAULT_GOAL:=ansible-lint
MAKEFLAGS=--warn-undefined-variables

playbooks:=$(wildcard playbooks/*.yml)
kaniko_img:=gcr.io/kaniko-project/executor:v1.9.1-debug

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
		-v "$(shell pwd):/worksapce:z" \
		-w /worksapce \
		$(kaniko_img) \
		./.gitlab/build_image.sh $(1) $(2)
	$(CONTAINER) load -i dockerfiles/dist/$(1)/$(1)-$(2).tar
endef

dockerfiles/dist/archlinux/archlinux-latest.tar: ./.gitlab/build_image.sh
dockerfiles/dist/archlinux/archlinux-latest.tar: dockerfiles/archlinux.dockerfile
	$(call build_image,archlinux,latest)

dockerfiles/dist/centos/centos-stream9.tar: ./.gitlab/build_image.sh
dockerfiles/dist/centos/centos-stream9.tar: dockerfiles/centos.dockerfile
	$(call build_image,centos,stream9)

dockerfiles/dist/debian/debian-11.tar: ./.gitlab/build_image.sh
dockerfiles/dist/debian/debian-11.tar: dockerfiles/debian.dockerfile
	$(call build_image,debian,11)

dockerfiles/dist/fedora/fedora-36.tar: ./.gitlab/build_image.sh
dockerfiles/dist/fedora/fedora-36.tar: dockerfiles/fedora.dockerfile
	$(call build_image,fedora,36)

dockerfiles/dist/fedora/fedora-37.tar: ./.gitlab/build_image.sh
dockerfiles/dist/fedora/fedora-37.tar: dockerfiles/fedora.dockerfile
	$(call build_image,fedora,37)

dockerfiles/dist/fedora/fedora-38.tar: ./.gitlab/build_image.sh
dockerfiles/dist/fedora/fedora-38.tar: dockerfiles/fedora.dockerfile
	$(call build_image,fedora,38)

dockerfiles/dist/manjarolinux/manjarolinux-latest.tar: ./.gitlab/build_image.sh
dockerfiles/dist/manjarolinux/manjarolinux-latest.tar: dockerfiles/manjarolinux.dockerfile
	$(call build_image,manjarolinux,latest)

dockerfiles/dist/ubuntu/ubuntu-22.04.tar: ./.gitlab/build_image.sh
dockerfiles/dist/ubuntu/ubuntu-22.04.tar: dockerfiles/ubuntu.dockerfile
	$(call build_image,ubuntu,22.04)

.PHONY: ansible-lint
ansible-lint:
	ansible-playbook --syntax-check $(playbooks)
	ansible-lint -p $(playbooks)

.PHONY: git_hooks
git_hooks: .git/hooks/pre-commit

define test_os
	@# $1 is the OS
	@# $2 is the OS_VERSION
	@# TODO: rustup executes files in /tmp. Needed to drop noexec
	if uname -a | grep '\-WSL'; then \
		$(CONTAINER) create \
			--env ANSIBLE_FORCE_COLOR=1 \
			--interactive \
			--name="scripts-$(1)-$(2)" \
			--rm \
			--tty \
			--volume="$(shell pwd):/scripts" \
			--workdir /scripts \
			"localhost/scripts-$(1):$(2)" || true; \
	else \
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
			"localhost/scripts-$(1):$(2)" /lib/systemd/systemd || true; \
	fi
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

.PHONY: test-centos-stream9
test-centos-stream9: dockerfiles/dist/centos/centos-stream9.tar
	$(call test_os,centos,stream9)

.PHONY: test-debian-11
test-debian-11: dockerfiles/dist/debian/debian-11.tar
	$(call test_os,debian,11)

.PHONY: test-fedora-36
test-fedora-36: dockerfiles/dist/fedora/fedora-36.tar
	$(call test_os,fedora,36)

.PHONY: test-fedora-37
test-fedora-37: dockerfiles/dist/fedora/fedora-37.tar
	$(call test_os,fedora,37)

.PHONY: test-fedora-38
test-fedora-38: dockerfiles/dist/fedora/fedora-38.tar
	$(call test_os,fedora,38)

.PHONY: test-manjarolinux-latest
test-manjarolinux-latest: dockerfiles/dist/manjarolinux/manjarolinux-latest.tar
	$(call test_os,manjarolinux,latest)

.PHONY: test-ubuntu-22.04
test-ubuntu-22.04: dockerfiles/dist/ubuntu/ubuntu-22.04.tar
	$(call test_os,ubuntu,22.04)
