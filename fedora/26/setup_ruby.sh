# Install rbenv
git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv"
cd "$HOME/.rbenv" && src/configure && make -C src && cd -
git clone https://github.com/rbenv/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
