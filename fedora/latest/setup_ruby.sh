# Install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src && cd -
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
