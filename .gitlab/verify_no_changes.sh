#!/bin/sh
set -xeu

git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/scripts'
git status --short && test "$(git status --short)" = ''

cd '/home/public/Applications/dotfiles'
git status --short && test "$(git status --short)" = ''
