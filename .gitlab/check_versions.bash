#!/usr/bin/env bash
set -xueo pipefail

# Make sure the PATH has the location of rust and python bins
PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:${HOME}/bin:$PATH"

# List installed tools
tools
# Now check the versions
1password --version || echo '1password unavailable'
ansible --version
bash --version
bat --version || echo 'bat unavailable'
cargo --version
cargo-clippy --version
code --version
curl --version
docker --version || echo 'docker unavailable'
docker compose version || echo 'docker compose unavailable'
exa --version || echo 'exa unavailable'
fd --version || echo 'fd unavailable'
flameshot --version || echo 'flameshot unavailable'
flatpak --version
gcc --version
git --version
gitui --version || echo 'gitui unavailable'
gzip --version
jq --version
keybase --version || echo 'keybase unavailable'
make --version
node --version
npm --version
op --version || echo 'op unavailable'
pip --version
podman --version
python --version || echo 'python unavailable'
python3 --version
rust-gdb --version
rustc --version
rustdoc --version
rustfmt --version
rustup --version
shellcheck --version || echo 'shellcheck unavailable'
ssh -V
tar --version
tree --version
unzip -v
virt-what --version || echo 'virt-what unavailable'
wget --version
xz --version
zoxide --version || echo 'zoxide unavailable'
zsh --version
# These commands do not have a version option
command -v gitk
