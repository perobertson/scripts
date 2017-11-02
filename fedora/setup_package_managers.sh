# Install RPM Fusion - Free & Non-Free
sudo dnf -y install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Allows for managing repos fromo cli
sudo dnf -y install dnf-plugins-core

# Add VirtualBox Repo
sudo dnf config-manager --add-repo http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

# Configure pip formatting
mkdir -p "$HOME/.config/pip"
cat > "$HOME/.config/pip/pip.conf" <<EOF
[list]
format=columns
EOF

# Sublime Text Repo
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

# Docker Repo
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
