#!/usr/bin/env bash

. "fedora/27/setup_package_managers.sh"
. "fedora/27/setup_virtualization.sh"
. "fedora/27/setup_dev_depends.sh"
. "fedora/27/setup_databases.sh"
. "fedora/27/setup_ides.sh"

# These do not require root
. "fedora/27/setup_python.sh"
. "fedora/27/setup_ruby.sh"
. "fedora/27/setup_dotfiles.sh"
. "fedora/27/user_settings.sh"
