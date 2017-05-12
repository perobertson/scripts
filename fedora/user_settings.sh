# Switch to zsh
sudo usermod -s $(which zsh) $(whoami)

# Change settings
gsettings set org.cinnamon.desktop.interface clock-show-seconds true
gsettings set org.cinnamon.desktop.interface gtk-theme 'Blue-Submarine'
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-X-Aqua'
gsettings set org.cinnamon.theme name 'Blue-Submarine'
gsettings set org.gnome.desktop.interface monospace-font-name 'Inconsolata Medium 10'

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources

# Install custom zsh themes and overrides
ln -s ~/workspace/scripts/.oh-my-zsh/themes ~/.oh-my-zsh/custom