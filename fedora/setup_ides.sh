# Install Sublime Text 3 Package Manager
wget -P "$HOME/.config/sublime-text-3/Installed Packages" https://packagecontrol.io/Package%20Control.sublime-package

# Configure IDE and plugins
mkdir -p "$HOME/.config/sublime-text-3/Packages/User"

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/SublimeLinter.sublime-settings" ]]; then
  cat > "$HOME/.config/sublime-text-3/Packages/User/SublimeLinter.sublime-settings" <<EOF
{
    "user": {
        "debug": false,
        "delay": 0.25,
        "error_color": "D02000",
        "gutter_theme": "Packages/SublimeLinter/gutter-themes/Default/Default.gutter-theme",
        "gutter_theme_excludes": [],
        "lint_mode": "background",
        "linters": {
            "flake8": {
                "@disable": false,
                "args": [],
                "builtins": "",
                "excludes": [],
                "executable": "$HOME/.local/bin/flake8",
                "ignore": "",
                "jobs": "",
                "max-complexity": "",
                "max-line-length": "240",
                "select": "",
                "show-code": true
            }
        },
        "mark_style": "outline",
        "no_column_highlights_line": false,
        "passive_warnings": false,
        "paths": {
            "linux": [],
            "osx": [],
            "windows": []
        },
        "python_paths": {
            "linux": [],
            "osx": [],
            "windows": []
        },
        "rc_search_limit": 3,
        "shell_timeout": 10,
        "show_errors_on_save": false,
        "show_marks_in_minimap": true,
        "syntax_map": {
            "coffeescript (gulpfile)": "coffeescript",
            "html (django)": "html",
            "html (rails)": "html",
            "html 5": "html",
            "javascript (babel)": "javascript",
            "javascript (eslint)": "javascript",
            "javascript (gruntfile)": "javascript",
            "javascript (gulpfile)": "javascript",
            "javascript (postcss)": "javascript",
            "javascript (stylelint)": "javascript",
            "javascript (webpack)": "javascript",
            "json (babel)": "json",
            "json (bower)": "json",
            "json (composer)": "json",
            "json (eslint)": "json",
            "json (npm)": "json",
            "json (postcss)": "json",
            "json (settings)": "json",
            "json (stylelint)": "json",
            "json (sublime)": "json",
            "json (tern js)": "json",
            "magicpython": "python",
            "php": "html",
            "python django": "python",
            "pythonimproved": "python",
            "xml (config)": "xml",
            "xml (svg)": "xml",
            "yaml (circleci)": "yaml",
            "yaml (docker)": "yaml",
            "yaml (eslint)": "yaml",
            "yaml (lock)": "yaml",
            "yaml (procfile)": "yaml",
            "yaml (stylelint)": "yaml",
            "yaml (yarn)": "yaml"
        },
        "tooltip_fontsize": "1rem",
        "tooltip_theme": "Packages/SublimeLinter/tooltip-themes/Default/Default.tooltip-theme",
        "tooltip_theme_excludes": [],
        "tooltips": false,
        "use_current_shell_path": false,
        "warning_color": "DDB700",
        "wrap_find": true
    }
}
EOF
fi

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings" ]]; then
  cat > "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings" <<EOF
{
  "default_line_ending": "unix",
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

if [[ ! -f "$HOME/.config/sublime-text-3/Packages/User/Python.sublime-settings" ]]; then
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
  cd "$HOME/.config/sublime-text-3/Packages/SublimeLinter" && git checkout v3.10.8 && cd - || exit 1
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8" ]]; then
  git clone https://github.com/SublimeLinter/SublimeLinter-flake8.git "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8"
  cd "$HOME/.config/sublime-text-3/Packages/SublimeLinter-flake8" && git checkout 3.0.2 && cd - || exit 1
fi
