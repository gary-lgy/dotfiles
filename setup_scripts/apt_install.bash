#!/usr/bin/env bash

# FIXME: not tested

if ! command -v apt-get &>/dev/null; then
  echo >&2 "Cannot find apt."
  exit 1
fi

apt_install() {
  # Do nothing if the package is already installed
  command -v "$1" &>/dev/null && echo "$1 is present." && return

  echo "$1 is not present. Installling with pacman..."

  # System upgrade
  if [ -z "$sys_upgraded" ]; then
    sudo apt update && sudo apt upgrade
    sys_upgraded=1
  fi

  sudo apt install "$1"
}

echo "Installing packages..."
packages=(git nvim curl bash-completion fish checkinstall fd silversearcher-ag xclip fasd htop pass)
for pac in "${packages[@]}"; do
  apt_install "$pac"
done

echo "Done."
echo "Install additional packages from nix."
