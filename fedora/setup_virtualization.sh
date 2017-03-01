# Package to help determine if running in a VM
sudo dnf -y install virt-what

sudo dnf -y install dkms \
                    kernel-headers kernel-headers-$(uname -r) \
                    kernel-devel-$(uname -r)

if [[ $(sudo virt-what | grep virtualbox) != '' ]]; then
  # sudo dnf -y install VirtualBox-guest-additions
  echo 'You must manually install guest additions from the CD because akmods does not update the additions after a kernel upgrade'
else
  sudo dnf -y install virt-manager \
                      libvirt \
                      qemu qemu-kvm
  # VirtualBox will fail to setup boxes on non UEFI systems
  sudo dnf -y install binutils \
                      gcc \
                      make \
                      patch \
                      libgomp \
                      glibc-headers glibc-devel
  sudo dnf -y install VirtualBox-5.1
  sudo usermod -a -G vboxusers $(whoami)
fi
