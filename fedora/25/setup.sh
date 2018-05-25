. "$os/$version/setup_package_managers.sh"
. "$os/$version/setup_virtualization.sh"
. "$os/$version/setup_dev_depends.sh"
. "$os/$version/setup_databases.sh"
. "$os/$version/setup_ides.sh"

# These do not require root
. "$os/$version/setup_python.sh"
. "$os/$version/setup_ruby.sh"
. "$os/$version/setup_dotfiles.sh"
. "$os/$version/user_settings.sh"
