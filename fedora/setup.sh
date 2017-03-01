# Perf tools
sudo dnf -y install htop dstat sysstat

# Package to help determine if running in a VM
sudo dnf -y install virt-what

if [[ $(sudo virt-what | grep virtualbox) != '' ]]; then
  echo 'Installing VirtualBox guest additions'
  sudo dnf -y install dkms \
                      kernel-devel-$(uname -r)
                      # VirtualBox-guest-additions
  echo 'You must manually install guest additions from the CD because akmods does not update the additions after a kernel upgrade'
else
  echo 'Installing virt-manager'
  sudo dnf -y install virt-manager libvirt qemu qemu-kvm
  # VirtualBox will fail to setup boxes on non UEFI systems
  echo 'Installiing VirtualBox'
  sudo dnf -y install binutils \
                      gcc \
                      make \
                      patch \
                      libgomp \
                      glibc-headers glibc-devel \
                      kernel-headers kernel-headers-$(uname -r) \
                      kernel-devel-$(uname -r) \
                      dkms
  sudo dnf -y install VirtualBox-5.1
  sudo usermod -a -G vboxusers $(whoami)
fi

# Dependencies for Ruby
sudo dnf -y install libyaml-devel \
                    libffi-devel \
                    autoconf \
                    gcc-c++ \
                    readline-devel \
                    zlib-devel \
                    openssl-devel \
                    automake \
                    libtool \
                    bison \
                    patch \
                    sqlite-devel

# Development dependencies
sudo dnf -y upgrade vim-minimal
sudo dnf -y install vim
sudo dnf -y install i3 \
                    zsh \
                    git \
                    wget \
                    ImageMagick \
                    graphviz \
                    samba \
                    redis \
                    sl \
                    p7zip bzip2 \
                    postgresql postgresql-server postgresql-contrib postgresql-devel \
                    levien-inconsolata-fonts \
                    freetype-freeworld \
                    dropbox pygpgme \
                    redhat-lsb

# Vagrant
\curl -sSL https://gist.githubusercontent.com/perobertson/ec90be267134180b1906439ff5667ac8/raw | bash

# PhantomJS
wget -P "$HOME/Downloads" https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar xvjf "$HOME/Downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" -C "$HOME/Applications"
ln -s "$HOME/Applications/phantomjs-2.1.1-linux-x86_64/bin/phantomjs" "$HOME/bin/phantomjs"

# Switch to zsh
sudo usermod -s $(which zsh) $(whoami)

# Setup Postgres
echo 'Installing Postgres'
sudo postgresql-setup --initdb
sudo systemctl start postgresql
sudo su --command="perl -p -i -e 's/host([\w :\/\.]*)ident/host\$1trust/g' /var/lib/pgsql/data/pg_hba.conf" --login postgres
sudo su --command="psql --command='CREATE ROLE $(whoami) WITH SUPERUSER LOGIN;'" --login postgres

# Enable services
echo 'Enabling Services'
sudo systemctl enable smb
sudo systemctl enable nmb
sudo systemctl enable redis
sudo systemctl enable postgresql

# Install updates
sudo dnf -y update kernel\* selinux\*

# Install rbenv
echo 'Installing rbenv'
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
. "$HOME/.bash_profile"
rbenv install 2.4.0
rbenv global 2.4.0
rbenv exec gem install bundler rake

# Set up dotfiles
echo 'Installing dotfiles'
git clone https://gitlab.com/perobertson/dotfiles.git "$HOME/workspace/dotfiles"
cd "$HOME/workspace/dotfiles"
rbenv exec rake install[true]

# Install Sublime Text 3
\curl -sSL https://gist.githubusercontent.com/perobertson/bbe9d0cced8ff2549a778ca718780a9b/raw | bash

# Clean up fonts
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources

echo -e '\nEverything installed. Be sure to reboot at your earliest convenience'
echo 'Remember to manually install guest additions from the CD if needed after reboot'
