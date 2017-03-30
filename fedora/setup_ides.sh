# Install Sublime Text 3
wget -P "$HOME/Downloads" https://download.sublimetext.com/sublime_text_3_build_3126_x64.tar.bz2
tar xvjf "$HOME/Downloads/sublime_text_3_build_3126_x64.tar.bz2" -C "$HOME/Applications"
wget -P "$HOME/.config/sublime-text-3/Installed Packages" https://packagecontrol.io/Package%20Control.sublime-package
ln -s "$HOME/Applications/sublime_text_3/sublime_text" "$HOME/bin/subl"
mkdir -p "$HOME/.local/share/applications"
echo "[Desktop Entry]
Encoding=UTF-8
Version=1.0
Terminal=false
Name=Sublime
Exec=subl
Icon=$(echo $HOME)/Applications/sublime_text_3/Icon/48x48/sublime-text.png
Categories=Development;TextEditor;
Type=Application" > "$HOME/.local/share/applications/sublime.desktop"
mkdir -p "$HOME/.config/sublime-text-3/Packages/User"
tee "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings" <<EOF
{
  "draw_white_space": "all",
  "ensure_newline_at_eof_on_save": true,
  "folder_exclude_patterns": [
    ".git",
    "__pycache__",
    "_site",
    "coverage",
    "env",
    "htmlcov",
    "log",
    "test/reports",
    "tmp/cache"
  ],
  "font_face": "Inconsolata",
  "font_options": [ "gray_antialias" ],
  "font_size": 13,
  "highlight_modified_tabs": true,
  "ignored_packages": [ "Vintage" ],
  "indent_guide_options": [ "draw_normal", "draw_active" ],
  "insert_final_newline": true,
  "line_padding_bottom": 1,
  "line_padding_top": 1,
  "tab_size": 2,
  "translate_tabs_to_spaces": true,
  "trim_trailing_white_space_on_save": true
}
EOF
