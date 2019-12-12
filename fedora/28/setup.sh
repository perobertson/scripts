#!/usr/bin/env bash

. "fedora/28/setup_package_managers.sh"
. "fedora/28/setup_virtualization.sh"
. "fedora/28/setup_dev_depends.sh"
. "fedora/28/setup_databases.sh"
. "fedora/28/setup_ides.sh"

# These do not require root
. "fedora/28/setup_python.sh"
. "fedora/28/setup_ruby.sh"
. "fedora/28/setup_dotfiles.sh"
. "fedora/28/user_settings.sh"
