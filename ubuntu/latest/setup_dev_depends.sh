#!/usr/bin/env bash

sudo apt-get install -y build-essential \
                        curl \
                        dstat \
                        htop \
                        libffi-dev \
                        libssl-dev \
                        python3 \
                        python3-pip \
                        ruby \
                        sysstat \
                        wget \
                        zsh

# Common gems that are used all the time
sudo gem install \
    bundler \
    rake

# Add python3 libs and tools
pip3 install --user --upgrade pip
hash -r
pip3 install --user \
    ansible
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

# Setup Heroku CLI
[[ ! -f "$HOME/Downloads/heroku.tar.gz" ]] && wget https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz -O "$HOME/Downloads/heroku.tar.gz"
mkdir -p "$HOME/Downloads/heroku"
# Heroku is annoying and does not put the version in the url so we have no idea what version just got downloaded
# Use globbing to get around that
tar -xzf "$HOME/Downloads/heroku.tar.gz" -C "$HOME/Downloads/heroku/"
mv "$HOME/Downloads/heroku/"* "$HOME/Applications/heroku/"
if [[ -f "$HOME/bin/heroku" ]]; then
    rm "$HOME/bin/heroku"
fi
ln -s "$HOME/Applications/heroku/bin/heroku" "$HOME/bin/heroku"
