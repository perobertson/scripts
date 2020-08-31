#!/usr/bin/env bash
set -xeuo pipefail

# Location of this script
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

su public --command="${HERE}/../setup.sh"

git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/scripts'
git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/dotfiles'
git status --short && test "$(git status --short)" = ''
