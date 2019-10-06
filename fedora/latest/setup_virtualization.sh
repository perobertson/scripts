#!/usr/bin/env bash

# Package to help determine if running in a VM
sudo dnf -y install dkms \
                    virt-what

# since this script is for new installs, we should be installing the headers from the default repo
sudo dnf config-manager --set-disabled updates
sudo dnf -y install kernel-headers \
                    kernel-devel
sudo dnf config-manager --set-enabled updates

install_docker(){
    sudo dnf -y install docker-ce
    sudo usermod -a -G docker "$(whoami)"
    sudo systemctl enable docker

    if [ ! -x "$(command -v docker-compose)" ]; then
        sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o '/usr/local/bin/docker-compose'
        sudo chmod +x '/usr/local/bin/docker-compose'
        [[ "$(sudo /usr/local/bin/docker-compose --version)" == 'docker-compose version 1.24.1, build 4667896b' ]] || exit 1
    fi
}

install_kubernetes(){
    sudo dnf -y install kubectl
    if [ ! -x "$(command -v minikube)" ]; then
        mkdir -p "$HOME/Applications/minikube"
        curl -Lo "$HOME/Applications/minikube/minikube" https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        chmod +x "$HOME/Applications/minikube/minikube"
        version="$("$HOME/Applications/minikube/minikube" version | cut -d' ' -f3)"
        mkdir -p "$HOME/Applications/minikube/$version"
        mv "$HOME/Applications/minikube/minikube" "$HOME/Applications/minikube/$version/"
        ln -s "$HOME/Applications/minikube/$version/minikube" "$HOME/bin"
    fi
}

install_kvm(){
    sudo dnf -y install libvirt \
                        qemu \
                        qemu-kvm \
                        virt-manager
}

install_podman(){
    sudo dnf -y install podman
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

install_podman
install_docker
install_kubernetes

# use grep because multiple results can be returned
if [[ "$(sudo virt-what)" = '' ]]; then
    # Bare Metal
    # dont install virtualbox because it breaks SecureBoot
    :
elif [[ "$(sudo virt-what | grep kvm)" != '' ]]; then
    set_guest_settings
else
    echo "[WARN] Unknown virtualization detected: '$(sudo virt-what)' skipping install of virtualization tools"
fi
