# Need to upgrade vim first, otherwise there are conflicts
sudo dnf -y upgrade vim-minimal
# Install vim separately due to conflicts in upgrade / install
sudo dnf -y install vim

sudo dnf -y install autoconf \
                    automake \
                    bison \
                    bzip2 \
                    certbot-nginx \
                    dropbox \
                    dstat \
                    freetype-freeworld \
                    gcc \
                    gcc-c++ \
                    git \
                    git-cola \
                    gitk \
                    graphviz \
                    htop \
                    i3 \
                    ImageMagick \
                    levien-inconsolata-fonts \
                    libcurl-devel \
                    libffi-devel \
                    libtool \
                    libyaml-devel \
                    make \
                    memcached \
                    nodejs \
                    openssl-devel \
                    p7zip \
                    patch \
                    perl \
                    pv \
                    pygpgme \
                    python-devel \
                    python2-pip \
                    python3-pip \
                    redhat-lsb \
                    redhat-rpm-config \
                    redis \
                    ruby \
                    ruby-devel \
                    samba \
                    sl \
                    sqlite-devel \
                    sublime-text \
                    sysstat \
                    readline-devel \
                    wget \
                    zlib-devel \
                    zsh

# TODO: This breaks the system install in CI and maybe for the user as well
# pip install --user --upgrade pip
# hash -r
pip install --user  bashate \
                    flake8 \
                    pep8-naming \
                    tldr \
                    virtualenv

# Switch to zsh
sudo usermod -s "$(which zsh)" "$(whoami)"

if [ ! -x "$(command -v vagrant)" -o "$(vagrant --version)" != 'Vagrant 2.0.3' ]; then
    sudo dnf -y install https://releases.hashicorp.com/vagrant/2.0.3/vagrant_2.0.3_x86_64.rpm
    [[ "$(vagrant --version)" == 'Vagrant 2.0.3' ]] || exit 1
fi

# Common gems that are used all the time
gem install bundler \
            rake

# Enable these for better hostname finding
sudo systemctl enable smb
sudo systemctl enable nmb

if [[ $(sudo virt-what) = '' ]]; then
    # Applications should be using containers
    sudo systemctl disable memcached
    sudo systemctl disable redis
else
    # Start caches when inside a VM
    sudo systemctl enable memcached
    sudo systemctl enable redis
fi

# Setup PhantomJS
[[ ! -f "$HOME/Downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" ]] && /usr/bin/curl -Lo "$HOME/Downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
[[ ! -d "$HOME/Applications/phantomjs-2.1.1-linux-x86_64" ]] && tar xvjf "$HOME/Downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" -C "$HOME/Applications"
if [[ -f "$HOME/bin/phantomjs" ]]; then
    rm "$HOME/bin/phantomjs"
fi
ln -s "$HOME/Applications/phantomjs-2.1.1-linux-x86_64/bin/phantomjs" "$HOME/bin/phantomjs"
[[ "$($HOME/bin/phantomjs --version)" == '2.1.1' ]] || exit 1

# Setup Heroku CLI
[[ ! -f "$HOME/Downloads/heroku.tar.gz" ]] && wget https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz -O "$HOME/Downloads/heroku.tar.gz"
mkdir -p "$HOME/Downloads/heroku"
# Heroku is annoying and does not put the version in the url so we have no idea what version just got downloaded
# Use globbing to get around that
tar -xzf "$HOME/Downloads/heroku.tar.gz" -C "$HOME/Downloads/heroku/"
mv "$HOME/Downloads/heroku/"* "$HOME/Applications/heroku/"
if [[ -f "$HOME/bin/heroku" ]]; then
    rm "$HOME/bin/heroku"
else
    ln -s "$HOME/Applications/heroku/bin/heroku" "$HOME/bin/heroku"
fi

# Setup Hub
[[ ! -f "$HOME/Downloads/hub-linux-amd64-2.2.9.tgz" ]] && /usr/bin/curl -Lo "$HOME/Downloads/hub-linux-amd64-2.2.9.tgz" https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz
[[ ! -d "$HOME/Applications/hub-linux-amd64-2.2.9" ]] && tar xzfv "$HOME/Downloads/hub-linux-amd64-2.2.9.tgz" -C "$HOME/Applications"
if [[ -f "$HOME/bin/hub" ]]; then
    rm "$HOME/bin/hub"
fi
ln -s "$HOME/Applications/hub-linux-amd64-2.2.9/bin/hub" "$HOME/bin/hub"
[[ "$($HOME/bin/hub --version | grep hub)" == 'hub version 2.2.9' ]] || exit 1
