#!/usr/bin/env bash
set -xueo pipefail

# Make sure the PATH has the location of rust and python bins
PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:${HOME}/bin:$PATH"

# List installed tools
tools
# Now check the versions
alacritty --version
ansible --version
bash --version
cargo --version
cargo-clippy --version
code --version
curl --version
docker --version
docker-compose --version
fd --version || echo 'fd unavailable'
flameshot --version
flatpak --version
gcc --version
git --version
gitui --version || echo 'gitui unavailable'
gzip --version
jq --version
keybase --version
make --version
node --version
npm --version
pip --version
python --version || echo 'python unavailable'
python3 --version
rust-gdb --version
rustc --version
rustdoc --version
rustfmt --version
rustup --version
shellcheck --version
ssh -V
tree --version
wget --version
xz --version
zsh --version
# These commands do not have a version option
command -v gitk
