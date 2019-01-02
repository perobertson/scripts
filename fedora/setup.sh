#!/usr/bin/env bash

os_version="$(. /etc/os-release && echo "$VERSION_ID")"
if [ -d "fedora/$os_version" ]; then
    version="$os_version"
else
    # Use the latest setup if there is no specific setup for the OS version
    version='latest'
fi

if [ "$version" == 'latest' ]; then
    . "fedora/latest/setup.sh"
elif [ "$version" == '27' ]; then
    . "fedora/27/setup.sh"
elif [ "$version" == '26' ]; then
    . "fedora/26/setup.sh"
elif [ "$version" == '25' ]; then
    . "fedora/25/setup.sh"
else
    echo "Fedora $os_version not supported"
    exit 1
fi
