#!/usr/bin/env bash

. "ubuntu/latest/setup_package_managers.sh"
. "ubuntu/latest/setup_dev_depends.sh"
. "ubuntu/latest/setup_databases.sh"
. "ubuntu/latest/setup_ides.sh"

# These do not require root
. "ubuntu/latest/setup_ruby.sh"
. "ubuntu/latest/setup_dotfiles.sh"
