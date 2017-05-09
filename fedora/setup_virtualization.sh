# Package to help determine if running in a VM
sudo dnf -y install virt-what

sudo dnf -y install dkms \
                    kernel-headers \
                    kernel-headers-$(uname -r) \
                    kernel-devel-$(uname -r)

if [[ $(sudo virt-what | grep virtualbox) != '' ]]; then
  sudo dnf -y install akmod-VirtualBox
  # TODO: delay before starting screensaver
  # TODO: lock computer when put to sleep
  # lock after screensaver starts
  gsettings set org.cinnamon.desktop.screensaver lock-enabled false
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
  sudo dnf -y install VirtualBox-5.1
  sudo usermod -a -G vboxusers $(whoami)
fi
