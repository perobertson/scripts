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
                    jq \
                    julia \
                    ImageMagick \
                    levien-inconsolata-fonts \
                    libcurl-devel \
                    libffi-devel \
                    libtool \
                    libyaml-devel \
                    make \
                    ncdu \
                    nodejs \
                    openssl-devel \
                    p7zip \
                    patch \
                    perl \
                    pssh \
                    pv \
                    python2-devel \
                    python2-pip \
                    python3-devel \
                    python3-dnf \
                    python3-pip \
                    readline-devel \
                    redhat-lsb \
                    redhat-rpm-config \
                    ruby \
                    ruby-devel \
                    samba-client \
                    ShellCheck \
                    sl \
                    sqlite-devel \
                    sshfs \
                    sublime-merge \
                    sublime-text \
                    sysstat \
                    vlc \
                    wget \
                    xz \
                    zlib-devel \
                    zsh

# get the latest pip version
pip install --user --upgrade pip
# force the shell to forget all remembered locations
hash -r

# use python3 as the default
pip3 install --user --upgrade pip
hash -r

pip3 install --user flake8 \
                    flake8-docstrings \
                    flake8-import-order \
                    ipdb \
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
rmdir "$HOME/Downloads/heroku/"
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
if [[ ! -d "$HOME/Applications/pyenv" ]]; then
    git clone https://github.com/pyenv/pyenv.git "$HOME/Applications/pyenv"
fi

# Install rbenv (Ruby version manager)
if [[ ! -d "$HOME/Applications/rbenv" ]]; then
    git clone https://github.com/rbenv/rbenv.git "$HOME/Applications/rbenv"
fi
if [[ ! -d "$HOME/Applications/rbenv/plugins/ruby-build" ]]; then
    git clone https://github.com/rbenv/ruby-build.git "$HOME/Applications/rbenv/plugins/ruby-build"
fi
cd "$HOME/Applications/rbenv" && src/configure && make -C src && cd - || exit 1

# Install tfenv (Terraform version manager)
if [[ ! -d "$HOME/Applications/tfenv" ]]; then
    git clone https://github.com/tfutils/tfenv.git "$HOME/Applications/tfenv"
fi
