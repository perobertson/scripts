sudo apt -y install build-essential \
                    curl \
                    dstat \
                    htop \
                    ruby \
                    sysstat \
                    wget \
                    zsh

# Common gems that are used all the time
sudo gem install bundler \
                 rake

# Setup PhantomJS
/usr/bin/curl -Lo "$HOME/Downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar xvjf "$HOME/Downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" -C "$HOME/Applications"
ln -s "$HOME/Applications/phantomjs-2.1.1-linux-x86_64/bin/phantomjs" "$HOME/bin/phantomjs"
