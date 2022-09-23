#!/usr/bin/bash
set -euo pipefail

# Do not run on metered connections
device=$(ip route list default | cut -d' ' -f5)
if [ -z "$device" ]
then
    echo "No default device found. Are you connected?"
    exit 1
elif nmcli -g GENERAL.METERED device show "$device" | grep '^yes' &>/dev/null
then
    echo "Metered connection detected"
    exit 2
fi
