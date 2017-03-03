# Switch to zsh
sudo usermod -s $(which zsh) $(whoami)

# Install updates
sudo dnf -y update kernel\* selinux\*

# Install Sublime Text 3
\curl -sSL https://gist.githubusercontent.com/perobertson/bbe9d0cced8ff2549a778ca718780a9b/raw | bash

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources
