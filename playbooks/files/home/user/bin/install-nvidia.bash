#!/usr/bin/env bash
# See https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/
# See https://blog.monosoul.dev/2021/12/29/automatically-sign-nvidia-kernel-module-in-fedora/

set -euo pipefail

generate_signing_key(){
    if sudo bash -c '[[ -f /opt/driver_signing/driver-signing.key ]]'; then
        echo "Driver signing key already exists"
        return 1
    elif sudo bash -c '[[ -f /opt/driver_signing/driver-signing.der ]]'; then
        echo "Driver signing key already exists"
        return 2
    fi
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
}

enroll_signing_key(){
    if sudo bash -c '[[ ! -f /opt/driver_signing/driver-signing.der ]]'; then
        generate_signing_key
    fi
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
    sudo dnf update
    echo "dependencies installed be sure to reboot"
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

    echo "Nouveau has been disabled."
    echo "Changing runlevel to multi-user"
    sudo systemctl set-default multi-user.target
    echo "Runlevel changed. Time to reboot and install the NVIDIA driver."
}

install_nvidia(){
    installer=$(find /opt/nvidia -name 'NVIDIA-*.run' | sort | tail -n 1)
    if [[ ! -x "${installer}" ]]; then
        echo "No installer found in /opt/nvidia"
        echo "See: https://www.nvidia.com/en-us/drivers/unix/"
        exit 3
    fi
    sudo "${installer}" \
        --module-signing-secret-key=/opt/driver_signing/driver-signing.key \
        --module-signing-public-key=/opt/driver_signing/driver-signing.der

    echo "NVIDIA has been installed"
    echo "Changing runlevel back to graphical"
    sudo systemctl set-default graphical.target
    echo "Runlevel changed. Time to reboot and install the video acceleration."
}

install_video_acceleration(){
    sudo dnf install \
        libva-utils \
        libva-vdpau-driver \
        vdpauinfo
}

help(){
   # Display Help
   echo "Multi step script to installing the NVIDA drivers."
   echo
   echo "Syntax: $0 [-a|d|e|g|h|i|n]"
   echo
   echo "options:"
   echo "-h     Print this help."
   echo "-g     Step1: Generate driver signing key for secure boot."
   echo "-e     Step2: Enroll driver signing key."
   echo "-d     Step3: Install NVIDIA dependencies."
   echo "-n     Step4: Disable nouveau driver."
   echo "-i     Step5: Install NVIDIA driver."
   echo "-a     Step6: Install video acceleration support."
}

while getopts ":adeghin" option; do
   case $option in
        a)
            install_video_acceleration
            exit
        ;;
        d)
            install_nvidia_dependencies
            exit
        ;;
        e)
            enroll_signing_key
            exit
        ;;
        g)
            generate_signing_key
            exit
        ;;
        h) # display Help
            help
            exit
        ;;
        i)
            install_nvidia
            exit
        ;;
        n)
            disable_nouveau
            exit
        ;;
        *)
            echo failed
            exit 1
   esac
done

help
