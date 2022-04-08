#!/usr/bin/bash
set -euo pipefail

# Do not run on metered connections
nmcli -g GENERAL.METERED device show "$(ip route list default | cut -d' ' -f5)" | grep -v '^yes'
