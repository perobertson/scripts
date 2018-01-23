# Package to help determine if running in a VM
sudo dnf -y install virt-what

sudo dnf -y install dkms \
                    kernel-headers \
                    kernel-headers-$(uname -r) \
                    kernel-devel-$(uname -r)

if [[ $(sudo virt-what | grep virtualbox) != '' ]]; then
  sudo dnf -y install akmod-VirtualBox
  # TODO: lock computer when put to sleep
  # lock after screensaver starts
  gsettings set org.cinnamon.desktop.screensaver lock-enabled false
  # delay before starting screensaver (disabled)
  gsettings set org.cinnamon.desktop.session idle-delay 0
else
  sudo dnf -y install libvirt \
                      qemu \
                      qemu-kvm \
                      virt-manager
  # VirtualBox will fail to setup boxes on non UEFI systems
  sudo dnf -y install binutils \
                      gcc \
                      libgomp \
                      make \
                      patch \
                      glibc-devel \
                      glibc-headers
  sudo dnf -y install VirtualBox-5.2 || exit 1
  sudo usermod -a -G vboxusers $(whoami)

  sudo dnf -y install docker-ce || exit 1
  sudo usermod -a -G docker $(whoami)
  sudo systemctl enable docker
  sudo systemctl start docker

  sudo curl -L "https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  [[ "$(docker-compose --version)" == 'docker-compose version 1.18.0, build 8dd22a9' ]] || exit 1
fi
