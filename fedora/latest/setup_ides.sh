# Install Sublime Text 3 Package Manager
wget -P "$HOME/.config/sublime-text-3/Installed Packages" https://packagecontrol.io/Package%20Control.sublime-package

# Configure IDE and plugins
mkdir -p "$HOME/.config/sublime-text-3/Packages/User"

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/SublimeLinter.sublime-settings" ]]; then
    cat > "$HOME/.config/sublime-text-3/Packages/User/SublimeLinter.sublime-settings" <<EOF
// SublimeLinter Settings - User
{
  "linters": {
    "bashate": {
      "ignore": "E006",
    },
    "flake8": {
      "python": null,
      "disable": false,
      "args": ["--ignore=E501"],
      "excludes": [],
      "ignore": "",
      "max-complexity": 10,
      "max-line-length": null,
      "select": ""
    },
    "rubocop": {
      "use_bundle_exec": true
    }
  },
  "paths": {
    "linux": [
      "~/.rbenv/shims",
      "~/.rbenv/bin",
      "~/bin",
      "~/.bin",
      "~/.local/bin"
    ],
    "osx": [],
    "windows": []
  },
}
EOF
fi

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings" ]]; then
    cat > "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings" <<EOF
{
  "default_line_ending": "unix",
  "drag_text": false,
  "draw_white_space": "all",
  "ensure_newline_at_eof_on_save": true,
  "folder_exclude_patterns":
  [
    ".git",
    "__pycache__",
    "_site",
    "coverage",
    "env",
    "htmlcov",
    "log",
    "test/reports",
    "tmp/cache",
  ],
  "font_face": "Inconsolata",
  "font_options":
  [
    "gray_antialias"
  ],
  "font_size": 13,
  "highlight_line": true,
  "highlight_modified_tabs": true,
  "ignored_packages":
  [
    "Vintage"
  ],
  "indent_guide_options":
  [
    "draw_normal",
    "draw_active"
  ],
  "insert_final_newline": true,
  "line_padding_bottom": 1,
  "line_padding_top": 1,
  "show_encoding": true,
  "show_line_endings": true,
  "tab_size": 2,
  "theme": "Adaptive.sublime-theme",
  "translate_tabs_to_spaces": true,
  "trim_trailing_white_space_on_save": true,
}
EOF
fi

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/Python.sublime-settings" ]]; then
    cat > "$HOME/.config/sublime-text-3/Packages/User/Python.sublime-settings" <<EOF
{
  "tab_size": 4,
}
EOF
fi

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/Shell-Unix-Generic.sublime-settings" ]]; then
    cat > "$HOME/.config/sublime-text-3/Packages/User/Shell-Unix-Generic.sublime-settings" <<EOF
{
  "extensions":
  [
    "bash",
    "sh",
    "zsh"
  ],
  "tab_size": 4,
}
EOF
fi

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/python_fiximports.sublime-settings" ]]; then
  cat > "$HOME/.config/sublime-text-3/Packages/User/python_fiximports.sublime-settings" <<EOF
{
  "split_import_statements": false,
}
EOF
fi

if [[ ! -d "$HOME/.config/sublime-text-3/Packages/Jedi - Python autocompletion" ]]; then
    git clone https://github.com/srusskih/SublimeJEDI.git "$HOME/.config/sublime-text-3/Packages/Jedi - Python autocompletion"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/Python Fix Imports" ]]; then
    git clone https://github.com/Stibbons/python-fiximports.git "$HOME/.config/sublime-text-3/Packages/Python Fix Imports"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter" ]]; then
    git clone https://github.com/SublimeLinter/SublimeLinter.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter"
    # only need to enable this checkout when breaking changes are happening
    # cd "$HOME/.config/sublime-text-3/Packages/SublimeLinter" && git checkout 4.1.1 && cd - || exit 1
fi
if [[ -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter-contrib-bashate" ]]; then
    git clone git@github.com:maristgeek/SublimeLinter-contrib-bashate.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter-contrib-bashate"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8" ]]; then
    git clone https://github.com/SublimeLinter/SublimeLinter-flake8.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8"
    # only need to enable this checkout when breaking changes are happening
    # cd "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8" && git checkout 4.0.1 && cd - || exit 1
fi
