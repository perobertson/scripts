# Switch to zsh
sudo usermod -s $(which zsh) $(whoami)

# Install updates
sudo dnf -y update kernel\* selinux\*

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources
