#!/usr/bin/env bash

os_version="$(. /etc/os-release && echo "$VERSION_ID")"
if [ -d "ubuntu/$os_version" ]; then
    version="$os_version"
else
    # Use the latest setup if there is no specific setup for the OS version
    version='latest'
fi

if [ "$version" == 'latest' ]; then
    . "ubuntu/latest/setup.sh"
else
    echo "Ubuntu $os_version not supported"
    exit 1
fi
