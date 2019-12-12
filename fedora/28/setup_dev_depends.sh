#!/usr/bin/env bash

# Need to upgrade vim first, otherwise there are conflicts
sudo dnf -y upgrade vim-minimal
# Install vim separately due to conflicts in upgrade / install
sudo dnf -y install vim

sudo dnf -y install \
                    autoconf \
                    automake \
                    bison \
                    bzip2 \
                    bzip2-devel \
                    certbot-nginx \
                    dropbox \
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
                    pssh \
                    pv \
                    python-devel \
                    python2-pip \
                    python3-pip \
                    readline-devel \
                    redhat-lsb \
                    redhat-rpm-config \
                    redis \
                    ruby \
                    ruby-devel \
                    samba \
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
pip install --user --upgrade pip==19.1.1
# force the shell to forget all remembered locations
hash -r
[[ "$(pip --version)" == "pip 19.1.1 from $HOME/.local/lib/python2.7/site-packages/pip (python 2.7)" ]] || \
    [[ "$(pip --version)" == "pip 19.1.1 from /usr/lib/python2.7/site-packages/pip (python 2.7)" ]]

pip3 install --user \
    ansible \
    bashate \
    flake8 \
    flake8-coding \
    flake8-docstrings \
    flake8-future-import \
    flake8-import-order \
    ipython \
    jedi \
    pdbpp \
    pep8-naming \
    poetry \
    pre-commit \
    tldr \
    virtualenv
pip3 check

# Switch to zsh
sudo usermod -s "$(command -v zsh)" "$(whoami)"

if [ ! -x "$(command -v vagrant)" ]; then
    sudo dnf -y install https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.rpm
elif [ "$(vagrant --version)" != 'Vagrant 2.2.4' ]; then
    sudo dnf -y install https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.rpm
fi
[[ "$(vagrant --version)" == 'Vagrant 2.2.4' ]] || exit 1

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
[[ "$("$HOME/bin/phantomjs" --version)" == '2.1.1' ]] || exit 1

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
[[ ! -f "$HOME/Downloads/hub-linux-amd64-2.7.0.tgz" ]] && /usr/bin/curl -Lo "$HOME/Downloads/hub-linux-amd64-2.7.0.tgz" https://github.com/github/hub/releases/download/v2.7.0/hub-linux-amd64-2.7.0.tgz
[[ ! -d "$HOME/Applications/hub-linux-amd64-2.7.0" ]] && tar xzfv "$HOME/Downloads/hub-linux-amd64-2.7.0.tgz" -C "$HOME/Applications"
if [[ -f "$HOME/bin/hub" ]]; then
    rm "$HOME/bin/hub"
fi
ln -s "$HOME/Applications/hub-linux-amd64-2.7.0/bin/hub" "$HOME/bin/hub"
[[ "$("$HOME/bin/hub" --version | grep hub)" == 'hub version 2.7.0' ]] || exit 1

# Setup Julia
[[ ! -f "$HOME/Downloads/julia-1.0.3-linux-x86_64.tar.gz" ]] && /usr/bin/curl -Lo "$HOME/Downloads/julia-1.0.3-linux-x86_64.tar.gz" https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.3-linux-x86_64.tar.gz
[[ ! -d "$HOME/Applications/julia-1.0.3" ]] && tar xzfv "$HOME/Downloads/julia-1.0.3-linux-x86_64.tar.gz" -C "$HOME/Applications"
if [[ -f "$HOME/bin/julia" ]]; then
    rm "$HOME/bin/julia"
fi
ln -s "$HOME/Applications/julia-1.0.3/bin/julia" "$HOME/bin/julia"
[[ "$("$HOME/bin/julia" --version)" == 'julia version 1.0.3' ]] || exit 1

# Setup Terraform
[[ ! -f "$HOME/Downloads/terraform_0.11.13_linux_amd64.zip" ]] && /usr/bin/curl -Lo "$HOME/Downloads/terraform_0.11.13_linux_amd64.zip" https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
[[ ! -d "$HOME/Applications/terraform_0.11.13" ]] && /usr/bin/unzip "$HOME/Downloads/terraform_0.11.13_linux_amd64.zip" -d "$HOME/Applications/terraform_0.11.13"
if [[ -f "$HOME/bin/terraform" ]]; then
    rm "$HOME/bin/terraform"
fi
ln -s "$HOME/Applications/terraform_0.11.13/terraform" "$HOME/bin/terraform"
[[ "$("$HOME/bin/terraform" version | head -1)" == 'Terraform v0.11.13' ]] || exit 1
