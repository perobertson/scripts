# Switch to zsh
sudo usermod -s $(which zsh) $(whoami)

# Change fonts
gsettings set org.gnome.desktop.interface monospace-font-name 'Inconsolata Medium 9'

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources
