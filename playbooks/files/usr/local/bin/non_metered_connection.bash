#!/usr/bin/bash
set -euo pipefail

# Do not run on metered connections
if nmcli -g GENERAL.METERED device show "$(ip route list default | cut -d' ' -f5)" | grep '^yes' &>/dev/null
then
    echo "metered connection detected"
    exit 1
fi
