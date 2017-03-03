# Switch to zsh
sudo usermod -s $(which zsh) $(whoami)

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources
