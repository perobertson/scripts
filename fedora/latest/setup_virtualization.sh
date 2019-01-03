#!/usr/bin/env bash

# Package to help determine if running in a VM
sudo dnf -y install dkms \
                    virt-what

# since this script is for new installs, we should be installing the headers from the default repo
sudo dnf config-manager --set-disabled updates
sudo dnf -y install kernel-headers \
                    kernel-devel
sudo dnf config-manager --set-enabled updates

install_kvm(){
    sudo dnf -y install libvirt \
                        qemu \
                        qemu-kvm \
                        virt-manager
}

install_virtualbox(){
    # VirtualBox will fail to setup boxes on non UEFI systems
    sudo dnf -y install binutils \
                        gcc \
                        libgomp \
                        make \
                        patch \
                        glibc-devel \
                        glibc-headers
    sudo dnf -y install VirtualBox-5.2
    sudo usermod -a -G vboxusers "$(whoami)"
}

install_virtualbox_guest(){
    sudo dnf -y install akmod-VirtualBox
}

install_docker(){
    sudo dnf -y install docker-ce
    sudo usermod -a -G docker "$(whoami)"
    sudo systemctl enable docker

    sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o '/usr/local/bin/docker-compose'
    sudo chmod +x '/usr/local/bin/docker-compose'
    [[ "$(docker-compose --version)" == 'docker-compose version 1.22.0, build f46880fe' ]] || exit 1
}

install_kubernetes(){
    if [ ! -x "$(command -v kubectl)" ]; then
        sudo dnf -y install kubectl
    fi
    if [ ! -x "$(command -v minikube)" ]; then
        mkdir -p "$HOME/Applications/minikube/v0.28.2"
        curl -Lo "$HOME/Applications/minikube/v0.28.2/minikube" https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64
        chmod +x "$HOME/Applications/minikube/v0.28.2/minikube"
        ln -s "$HOME/Applications/minikube/v0.28.2/minikube" "$HOME/bin"
    fi
}

set_guest_settings(){
    # TODO: lock computer when put to sleep
    if [[ "$(gsettings list-schemas | grep org.cinnamon.desktop.screensaver)" != '' ]]; then
        # lock after screensaver starts
        gsettings set org.cinnamon.desktop.screensaver lock-enabled false
    fi
    if [[ "$(gsettings list-schemas | grep org.cinnamon.desktop.session)" != '' ]]; then
        # delay before starting screensaver (disabled)
        gsettings set org.cinnamon.desktop.session idle-delay 0
    fi
}

# use grep because multiple results can be returned
if [[ "$(sudo virt-what)" = '' ]]; then
    # Bare Metal
    # dont install virtualbox because it breaks SecureBoot
    install_kvm
    install_docker
    install_kubernetes
elif [[ "$(sudo virt-what | grep virtualbox)" != '' ]]; then
    install_virtualbox_guest
    set_guest_settings
elif [[ "$(sudo virt-what | grep kvm)" != '' ]]; then
    set_guest_settings
else
    echo "[WARN] Unknown virtualization detected: '$(sudo virt-what)' skipping install of virtualization tools"
fi
