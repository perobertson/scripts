#!/usr/bin/env bash
set -xeuo pipefail

# Location of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

su public --command="${SCRIPT_DIR}/../setup.sh"

git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/scripts'
git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/dotfiles'
git status --short && test "$(git status --short)" = ''
