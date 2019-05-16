# Change settings
if [[ "$(gsettings list-schemas | grep org.cinnamon.desktop.interface)" != '' ]]; then
    gsettings set org.cinnamon.desktop.interface clock-show-seconds true
    gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-X-Aqua'
fi
if [[ "$(gsettings list-schemas | grep org.gnome.desktop.interface)" != '' ]]; then
    gsettings set org.gnome.desktop.interface monospace-font-name 'Inconsolata Medium 10'
fi

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > "$HOME/.Xresources"
