#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob
shopt -s nullglob

# default location for code
REMOTE_CODE="${CODE_PATH:-$HOME/code}"
LOCAL_CODE="${REMOTE_CODE}"

usage() {
  echo -e "Basic usage: $0"\\n
  echo -e "The following switches are recognized."
  echo -e "-e --external  -- Address to use on external networks"
  echo -e "-i --internal  -- Address to use on internal networks"
  echo -e "-l --local     -- Local path to code"
  echo -e "-r --remote    -- Remote path to code"
  echo -e "-u --umount    -- Unmount local directory"
  echo -e "-h --help      -- Displays this help message. No further functions are performed."\\n
  echo -e "Example: $0 -e example.com -i 192.168.0.100 -r /var/code -l $HOME/code"\\n
  exit 0
}

umnt() {
  if grep -q " ${LOCAL_CODE}.*fuse.sshfs " /etc/mtab; then
    fusermount -u "${LOCAL_CODE}"
  fi
}

mnt() {
  if [[ -n "${INTERNAL_DNS:-}" ]] && nc -z "${INTERNAL_DNS}" 22 2>/dev/null; then
    echo "Mounting ${INTERNAL_DNS}"
    server="${INTERNAL_DNS}"
  elif [[ -n "${EXTERNAL_DNS:-}" ]] && nc -z "${EXTERNAL_DNS}" 22 2>/dev/null; then
    echo "Mounting ${EXTERNAL_DNS}"
    server="${EXTERNAL_DNS}"
  else
    echo -e "Could not connect to server\nInternal: ${INTERNAL_DNS:-}\nExternal: ${EXTERNAL_DNS:-}"
    exit 1
  fi

  for _ in "${LOCAL_CODE}"/*; do
    echo "Cannot mount to non empty directory: $LOCAL_CODE"
    exit 1
  done

  if ! grep -q " ${LOCAL_CODE}.*fuse.sshfs " /etc/mtab; then
    sshfs "${server}:${REMOTE_CODE}" "${LOCAL_CODE}" \
      -o compression=yes \
      -o delay_connect \
      -o idmap=user \
      -o reconnect
  fi
}

for arg in "$@"; do
  shift
  case "$arg" in
    "--external") set -- "$@" "-e" ;;
    "--help")     set -- "$@" "-h" ;;
    "--internal") set -- "$@" "-i" ;;
    "--local")    set -- "$@" "-l" ;;
    "--remote")   set -- "$@" "-r" ;;
    "--umount")   set -- "$@" "-u" ;;
    *)            set -- "$@" "$arg"
  esac
done

while getopts e:hi:l:r:u FLAG; do
  case $FLAG in
    e) EXTERNAL_DNS="$OPTARG" ;;
    h) usage ;;
    i) INTERNAL_DNS="$OPTARG" ;;
    l) LOCAL_CODE="$OPTARG" ;;
    r) REMOTE_CODE="$OPTARG" ;;
    u) UNMOUNT=1 ;;
    \?) #unrecognized option - show usage
      usage
      ;;
  esac
done

if [[ -n "${UNMOUNT:-}" ]]; then
  umnt
else
  mnt
fi
