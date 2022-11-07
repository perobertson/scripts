#!/bin/sh
set -xeu

pwd
git status --short && test "$(git status --short)" = ''

cd '/home/public/workspace/perobertson/scripts'
git status --short && test "$(git status --short)" = ''

cd '/home/public/workspace/perobertson/dotfiles'
git status --short && test "$(git status --short)" = ''
