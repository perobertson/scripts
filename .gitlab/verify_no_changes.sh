#!/bin/sh
set -xeu

pwd
git status --short && test "$(git status --short)" = ''

cd '/home/public/workspace/gitlab.com/perobertson/scripts'
git status --short && test "$(git status --short)" = ''

cd '/home/public/workspace/gitlab.com/perobertson/dotfiles'
git status --short && test "$(git status --short)" = ''
