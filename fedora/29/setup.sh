#!/usr/bin/env bash

. "fedora/latest/setup_package_managers.sh"
. "fedora/latest/setup_virtualization.sh"
. "fedora/latest/setup_dev_depends.sh"
. "fedora/latest/setup_databases.sh"
. "fedora/latest/setup_ides.sh"

# These do not require root
. "fedora/latest/setup_dotfiles.sh"
. "fedora/latest/user_settings.sh"
