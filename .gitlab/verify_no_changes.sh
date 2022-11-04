#!/bin/sh
set -xeu

git status --short && test "$(git status --short)" = ''

cd '/home/public/workspace/perobertson/scripts'
git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/dotfiles'
git status --short && test "$(git status --short)" = ''
