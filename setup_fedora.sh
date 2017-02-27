#!/usr/bin/env bash

set -x

./dnf_config.sh
./install_perf_tools.sh
./install_vm_tools.sh
