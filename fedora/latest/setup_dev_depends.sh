#!/usr/bin/env bash

# Need to upgrade vim first, otherwise there are conflicts
sudo dnf -y upgrade vim-minimal
# Install vim separately due to conflicts in upgrade / install
sudo dnf -y install vim

sudo dnf -y install ansible \
                    autoconf \
                    automake \
                    bat \
                    bison \
                    bzip2 \
                    bzip2-devel \
                    dropbox \
                    dstat \
                    freetype-freeworld \
                    fzf \
                    gcc \
                    gcc-c++ \
                    git \
                    git-cola \
                    gitk \
                    google-cloud-sdk \
                    graphviz \
                    gtk-murrine-engine \
                    htop \
                    i3 \
                    julia \
                    ImageMagick \
                    levien-inconsolata-fonts \
                    libcurl-devel \
                    libffi-devel \
                    libtool \
                    libyaml-devel \
                    make \
                    memcached \
                    ncdu \
                    nodejs \
                    openssl-devel \
                    p7zip \
                    patch \
                    perl \
                    pssh \
                    pv \
                    python-devel \
                    python2-pip \
                    python3-dnf \
                    python3-pip \
                    readline-devel \
                    redhat-lsb \
                    redhat-rpm-config \
                    redis \
                    ruby \
                    ruby-devel \
                    samba-client \
                    ShellCheck \
                    sl \
                    sqlite-devel \
                    sublime-merge \
                    sublime-text \
                    sysstat \
                    vlc \
                    wget \
                    zlib-devel \
                    zsh

# get the latest pip version
PIP_VERSION=19.2.1
pip install --user --upgrade "pip==${PIP_VERSION}"
# force the shell to forget all remembered locations
hash -r
[[ "$(pip --version)" == "pip ${PIP_VERSION} from $HOME/.local/lib/python2.7/site-packages/pip (python 2.7)" ]] || \
    [[ "$(pip --version)" == "pip ${PIP_VERSION} from /usr/lib/python2.7/site-packages/pip (python 2.7)" ]]
pip3 install --user bashate \
                    flake8 \
                    flake8-docstrings \
                    flake8-future-import \
                    flake8-import-order \
                    ipython \
                    jedi \
                    pdbpp \
                    pep8-naming \
                    poetry \
                    pre-commit \
                    termcolor
pip3 check

# Switch to zsh
sudo usermod -s "$(command -v zsh)" "$(whoami)"

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
[[ "$("$HOME/bin/phantomjs" --version)" == '2.1.1' ]] || exit 1

# Setup Heroku CLI
[[ ! -f "$HOME/Downloads/heroku.tar.gz" ]] && wget https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz -O "$HOME/Downloads/heroku.tar.gz"
mkdir -p "$HOME/Downloads/heroku"
# Heroku is annoying and does not put the version in the url so we have no idea what version just got downloaded
# Use globbing to get around that
tar -xzf "$HOME/Downloads/heroku.tar.gz" -C "$HOME/Downloads/heroku/"
if [[ -d "$HOME/Applications/heroku" ]]; then
    rm -rf "$HOME/Applications/heroku"
fi
mv "$HOME/Downloads/heroku/"* "$HOME/Applications/heroku/"
if [[ -f "$HOME/bin/heroku" ]]; then
    rm "$HOME/bin/heroku"
else
    ln -s "$HOME/Applications/heroku/bin/heroku" "$HOME/bin/heroku"
fi

# Setup Hub
[[ ! -f "$HOME/Downloads/hub-linux-amd64-2.7.0.tgz" ]] && /usr/bin/curl -Lo "$HOME/Downloads/hub-linux-amd64-2.7.0.tgz" https://github.com/github/hub/releases/download/v2.7.0/hub-linux-amd64-2.7.0.tgz
[[ ! -d "$HOME/Applications/hub-linux-amd64-2.7.0" ]] && tar xzfv "$HOME/Downloads/hub-linux-amd64-2.7.0.tgz" -C "$HOME/Applications"
if [[ -f "$HOME/bin/hub" ]]; then
    rm "$HOME/bin/hub"
fi
ln -s "$HOME/Applications/hub-linux-amd64-2.7.0/bin/hub" "$HOME/bin/hub"
[[ "$("$HOME/bin/hub" --version | grep hub)" == 'hub version 2.7.0' ]] || exit 1

# Install pyenv (Python version manager)
if [[ ! -d "$HOME/.pyenv" ]]; then
    git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
fi

# Install rbenv (Ruby version manager)
if [[ ! -d "$HOME/.rbenv" ]]; then
    git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv"
fi
cd "$HOME/.rbenv" && src/configure && make -C src && cd - || exit 1
if [[ ! -d "$HOME/.rbenv/plugins/ruby-build" ]]; then
    git clone https://github.com/rbenv/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
fi

# Install tfenv (Terraform version manager)
if [[ ! -d "$HOME/.tfenv" ]]; then
    git clone https://github.com/tfutils/tfenv.git "$HOME/.tfenv"
fi
