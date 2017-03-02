# Vagrant
\curl -sSL https://gist.githubusercontent.com/perobertson/ec90be267134180b1906439ff5667ac8/raw | bash

# PhantomJS
wget -P "$HOME/Downloads" https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar xvjf "$HOME/Downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" -C "$HOME/Applications"
ln -s "$HOME/Applications/phantomjs-2.1.1-linux-x86_64/bin/phantomjs" "$HOME/bin/phantomjs"

# Switch to zsh
sudo usermod -s $(which zsh) $(whoami)

# Enable services
echo 'Enabling Services'
sudo systemctl enable smb
sudo systemctl enable nmb
sudo systemctl enable redis

# Install updates
sudo dnf -y update kernel\* selinux\*

# Install Sublime Text 3
\curl -sSL https://gist.githubusercontent.com/perobertson/bbe9d0cced8ff2549a778ca718780a9b/raw | bash

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources

echo -e '\nEverything installed. Be sure to reboot at your earliest convenience'
echo 'Remember to manually install guest additions from the CD if needed after reboot'
