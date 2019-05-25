#!/usr/bin/env bash

# Note: no longer updated

trap "echo 'Cancelled.'; exit 255" SIGINT

if ! command -v apt-get &>/dev/null; then
  echo >&2 "Cannot find apt."
  exit 1
fi

# List of packages to install
packages=(git stow neovim curl bash-completion fish fd silversearcher-ag xclip fasd tree htop pass buku ranger w3m poppler)

apt_install() {
  # Do nothing if the package is already installed
  dpkg-query -W -f '${Status}' "$1" | grep -q "ok installed" && echo "$1 is present." && return

  echo "$1 is not present. Installling with apt"

  # System upgrade
  if [ -z "$sys_upgraded" ]; then
    sudo apt update && sudo apt upgrade
    sys_upgraded=1
  fi

  sudo apt install "$1"
}

echo "Installing packages..."
for pac in "${packages[@]}"; do
  apt_install "$pac"
done

echo "Done."
echo "Install additional packages from nix."
