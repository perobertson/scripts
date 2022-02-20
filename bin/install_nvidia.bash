#!/usr/bin/env bash
# See https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/

generate_signing_key(){
    sudo dnf install \
        mokutil \
        openssl
    sudo mkdir -p /opt/driver_signing
    sudo chmod 0700 /opt/driver_signing
    sudo openssl req \
        -new \
        -x509 \
        -newkey rsa:4096 \
        -keyout /opt/driver_signing/driver-signing.key \
        -outform DER \
        -out /opt/driver_signing/driver-signing.der \
        -nodes \
        -days 36500 \
        -subj "/CN=Private Driver Signing"

    sudo mokutil --import /opt/driver_signing/driver-signing.der

    echo "Key is enrolled, be sure to reboot before proceeding."
}

install_nvidia_dependencies(){
    sudo dnf install \
        acpid \
        dkms \
        gcc \
        kernel-devel \
        kernel-headers \
        libglvnd-devel \
        libglvnd-glx \
        libglvnd-opengl \
        make \
        pkgconfig
}

disable_nouveau(){
    if ! grep "blacklist nouveau" /etc/modprobe.d/*; then
        echo "blacklist nouveau" | sudo tee /etc/modprobe.d/disable_nouveau.conf
    fi

    # prevent the nouveau driver from loading
    if ! grep "^GRUB_CMDLINE_LINUX=.*rd.driver.blacklist=nouveau" /etc/default/grub; then
        sudo sed --in-place=.bak 's/^\(GRUB_CMDLINE_LINUX=".*\)"$/\1 rd.driver.blacklist=nouveau"/' /etc/default/grub

        # for both BIOS and UEFI after fedora 34
        sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    fi

    # Uninstall nouveau driver
    sudo dnf remove xorg-x11-drv-nouveau

    # generate_initramfs
    ## Backup old initramfs nouveau image ##
    sudo mv "/boot/initramfs-$(uname -r).img" "/boot/initramfs-$(uname -r)-nouveau.img"

    ## Create new initramfs image ##
    sudo dracut "/boot/initramfs-$(uname -r).img" "$(uname -r)"
}

# ./NVIDIA... \
#     --module-signing-secret-key=MODULE-SIGNING-SECRET-KEY
#     --module-signing-public-key=MODULE-SIGNING-PUBLIC-KEY


help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: $0 [-h]"
   echo "options:"
   echo "h     Print this help."
   echo
}

while getopts ":hg" option; do
   case $option in
        h) # display Help
            help
            exit
        ;;
        g)
            generate_signing_key
        ;;
        *)
            echo failed
            exit 1
   esac
done
