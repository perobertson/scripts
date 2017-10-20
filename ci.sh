if [ ! -z "$CI" ]; then
  os=$(. /etc/os-release && echo $ID)
  if [ "$os" = 'fedora' ]; then
    dnf install -y sudo
  else
    apt-get update
    apt-get install -y sudo
  fi
fi
