#!/usr/bin/env bash

# Configure IDE and plugins
mkdir -p "$HOME/.config/sublime-text-3/Installed Packages"
mkdir -p "$HOME/.config/sublime-text-3/Packages/User"

# Install Sublime Text 3 Package Manager
if [[ ! -f "$HOME/.config/sublime-text-3/Installed Packages/Package Control.sublime-package" ]]; then
    curl -o "$HOME/.config/sublime-text-3/Installed Packages/Package Control.sublime-package" -L 'https://packagecontrol.io/Package%20Control.sublime-package'
fi

# Install packages
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/ApplySyntax" ]]; then
    git clone https://github.com/facelessuser/ApplySyntax.git "$HOME/.config/sublime-text-3/Packages/ApplySyntax"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/Docker.tmbundle" ]]; then
    git clone https://github.com/asbjornenge/Docker.tmbundle.git "$HOME/.config/sublime-text-3/Packages/Docker.tmbundle"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/EditorConfig" ]]; then
    git clone https://github.com/sindresorhus/editorconfig-sublime.git "$HOME/.config/sublime-text-3/Packages/EditorConfig"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/FileIcons" ]]; then
    git clone https://github.com/braver/FileIcons.git "$HOME/.config/sublime-text-3/Packages/FileIcons"
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
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/Python Fix Imports" ]]; then
    git clone https://github.com/Stibbons/python-fiximports.git "$HOME/.config/sublime-text-3/Packages/Python Fix Imports"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/StGitlab" ]]; then
    git clone https://github.com/tosher/StGitlab.git "$HOME/.config/sublime-text-3/Packages/StGitlab"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/sublime-nginx" ]]; then
    git clone https://github.com/brandonwamboldt/sublime-nginx.git "$HOME/.config/sublime-text-3/Packages/sublime-nginx"
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
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/Terraform.tmLanguage" ]]; then
    git clone https://github.com/alexlouden/Terraform.tmLanguage.git "$HOME/.config/sublime-text-3/Packages/Terraform.tmLanguage"
fi
if [[ ! -d "$HOME/.config/sublime-text-3/Packages/TOML" ]]; then
    git clone https://github.com/jasonwilliams/sublime_toml_highlighting.git "$HOME/.config/sublime-text-3/Packages/TOML"
fi
