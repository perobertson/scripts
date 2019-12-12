#!/usr/bin/env bash

. "fedora/29/setup_package_managers.sh"
. "fedora/29/setup_virtualization.sh"
. "fedora/29/setup_dev_depends.sh"
. "fedora/29/setup_databases.sh"
. "fedora/29/setup_ides.sh"

# These do not require root
. "fedora/29/setup_dotfiles.sh"
. "fedora/29/user_settings.sh"
