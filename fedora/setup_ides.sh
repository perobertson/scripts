# Install Sublime Text 3 Package Manager
wget -P "$HOME/.config/sublime-text-3/Installed Packages" https://packagecontrol.io/Package%20Control.sublime-package

# Configure IDE and plugins
mkdir -p "$HOME/.config/sublime-text-3/Packages/User"
cat > "$HOME/.config/sublime-text-3/Packages/User/Flake8Lint.sublime-settings" <<EOF
{
  "popup": false,
  "ignore": [
    "E501", // line length
    "I100", // import order
    "I201", // newline before section of imports
    "D100", // doc public module
    "D101", // doc public class
    "D102", // doc public method
    "D103", // doc public function
    "D105", // doc magic
    "D200", // doc oneline
    "D400", // doc end with period
    "E265", // block comments start with #
  ],
}
EOF
cat > "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings" <<EOF
{
  "default_line_ending": "unix",
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
    "tmp/cache",
  ],
  "font_face": "Inconsolata",
  "font_options": [ "gray_antialias" ],
  "font_size": 13,
  "highlight_line": true,
  "highlight_modified_tabs": true,
  "ignored_packages": [ "Vintage" ],
  "indent_guide_options": [ "draw_normal", "draw_active" ],
  "insert_final_newline": true,
  "line_padding_bottom": 1,
  "line_padding_top": 1,
  "tab_size": 2,
  "translate_tabs_to_spaces": true,
  "trim_trailing_white_space_on_save": true,
}
EOF
cat > "$HOME/.config/sublime-text-3/Packages/User/Python.sublime-settings" <<EOF
{
  "tab_size": 4,
}
EOF
cat > "$HOME/.config/sublime-text-3/Packages/User/python_fiximports.sublime-settings" <<EOF
{
  "split_import_statements": false,
}
EOF

git clone https://github.com/srusskih/SublimeJEDI.git "$HOME/.config/sublime-text-3/Packages/Jedi - Python autocompletion"
git clone https://github.com/Stibbons/python-fiximports.git "$HOME/.config/sublime-text-3/Packages/Python Fix Imports"
git clone https://github.com/dreadatour/Flake8Lint.git "$HOME/.config/sublime-text-3/Packages/Python Flake8 Lint"
