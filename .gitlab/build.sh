#!/usr/bin/env bash
set -xeuo pipefail

# Location of this script
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ -n "${CI:-}" ]]; then
    su public --command="/usr/bin/curl -sSL https://gitlab.com/perobertson/scripts/raw/${CI_COMMIT_SHA}/setup.sh | bash"
else
    su public --command="${HERE}/../setup.sh"
fi

git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/scripts'
git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/dotfiles'
git status --short && test "$(git status --short)" = ''
