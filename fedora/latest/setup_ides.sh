#!/usr/bin/env bash

# Configure IDE and plugins
mkdir -p "$HOME/.config/sublime-text-3/Installed Packages"
mkdir -p "$HOME/.config/sublime-text-3/Packages/User"

# Install Sublime Text 3 Package Manager
if [[ ! -f "$HOME/.config/sublime-text-3/Installed Packages/Package Control.sublime-package" ]]; then
    curl -o "$HOME/.config/sublime-text-3/Installed Packages/Package Control.sublime-package" -L 'https://packagecontrol.io/Package%20Control.sublime-package'
fi

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/SublimeLinter.sublime-settings" ]]; then
    cat > "$HOME/.config/sublime-text-3/Packages/User/SublimeLinter.sublime-settings" <<EOF
// SublimeLinter Settings - User
{
  "linters": {
    "bashate": {
      "ignore": "E006",
      "selector": "source.shell",
    },
    "flake8": {
      "python": "~/.pyenv/shims/python",
      "disable": false,
      "args": [
        // E501: line length
        // D100: Docstring public module
        // D101: Docstring public class
        // D102: Docstring public method
        // D102: Docstring public function
        // I100: imports groups in wrong order
        "--ignore=E501,D100,D101,D102,D103",
        // Override any project setting
        "--select=A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z"
      ],
      "excludes": [],
      "ignore": "",
      "max-complexity": 10,
      "max-line-length": null,
      "select": ""
    },
    "rubocop": {
      "use_bundle_exec": true
    },
    "shellcheck": {
      "args": [
        "--external-sources"
      ]
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
    ".eggs",
    ".git",
    ".pytest_cache",
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

if [[ ! -d "$HOME/.config/sublime-text-3/Packages/ApplySyntax" ]]; then
    git clone https://github.com/facelessuser/ApplySyntax.git "$HOME/.config/sublime-text-3/Packages/ApplySyntax"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/Docker.tmbundle" ]]; then
    git clone https://github.com/asbjornenge/Docker.tmbundle.git "$HOME/.config/sublime-text-3/Packages/Docker.tmbundle"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/FileIcons" ]]; then
    git clone https://github.com/braver/FileIcons.git "$HOME/.config/sublime-text-3/Packages/FileIcons"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/GitGutter" ]]; then
    git clone https://github.com/jisaacks/GitGutter.git "$HOME/.config/sublime-text-3/Packages/GitGutter"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/Jedi - Python autocompletion" ]]; then
    git clone https://github.com/srusskih/SublimeJEDI.git "$HOME/.config/sublime-text-3/Packages/Jedi - Python autocompletion"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/jinja2-tmbundle" ]]; then
    git clone https://github.com/kudago/jinja2-tmbundle.git "$HOME/.config/sublime-text-3/Packages/jinja2-tmbundle"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/json_reindent" ]]; then
    git clone https://github.com/ThomasKliszowski/json_reindent.git "$HOME/.config/sublime-text-3/Packages/json_reindent"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/sublime-nginx" ]]; then
    git clone https://github.com/brandonwamboldt/sublime-nginx.git "$HOME/.config/sublime-text-3/Packages/sublime-nginx"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/Python Fix Imports" ]]; then
    git clone https://github.com/Stibbons/python-fiximports.git "$HOME/.config/sublime-text-3/Packages/Python Fix Imports"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter" ]]; then
    git clone https://github.com/SublimeLinter/SublimeLinter.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter"
    # only need to enable this checkout when breaking changes are happening
    # cd "$HOME/.config/sublime-text-3/Packages/SublimeLinter" && git checkout 4.1.1 && cd - || exit 1
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter-contrib-bashate" ]]; then
    git clone https://github.com/maristgeek/SublimeLinter-contrib-bashate.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter-contrib-bashate"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8" ]]; then
    git clone https://github.com/SublimeLinter/SublimeLinter-flake8.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8"
    # only need to enable this checkout when breaking changes are happening
    # cd "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8" && git checkout 4.0.1 && cd - || exit 1
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter-rubocop" ]]; then
    git clone https://github.com/SublimeLinter/SublimeLinter-rubocop.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter-rubocop"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter-shellcheck" ]]; then
    git clone https://github.com/SublimeLinter/SublimeLinter-shellcheck.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter-shellcheck"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/sublime-text-2-ini" ]]; then
    git clone https://github.com/clintberry/sublime-text-2-ini.git "$HOME/.config/sublime-text-3/Packages/sublime-text-2-ini"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/sublime-text-git" ]]; then
    git clone https://github.com/kemayo/sublime-text-git.git "$HOME/.config/sublime-text-3/Packages/sublime-text-git"
fi
