#!/usr/bin/env bash

# Change settings
if [[ "$(gsettings list-schemas | grep org.cinnamon.desktop.interface)" != '' ]]; then
    gsettings set org.cinnamon.desktop.interface clock-show-seconds true
    gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-X-Aqua'
fi
if [[ "$(gsettings list-schemas | grep org.gnome.desktop.interface)" != '' ]]; then
    gsettings set org.gnome.desktop.interface monospace-font-name 'Inconsolata Medium 11'
fi
if [[ "$(gsettings list-schemas | grep org.nemo.preferences)" != '' ]]; then
    gsettings set org.nemo.preferences date-format 'iso'
    gsettings set org.nemo.preferences default-folder-viewer 'list-view'
fi

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > "$HOME/.Xresources"

# Install custom zsh plugins, themes, and overrides
ln -s "$HOME/workspace/scripts/.oh-my-zsh/plugins/pip" "$HOME/.oh-my-zsh/custom/plugins/"
ln -s "$HOME/workspace/scripts/.oh-my-zsh/themes/pygmalion.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/"
