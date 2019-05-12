#!/usr/bin/env bash

trap "echo 'Cancelled.'; exit 255" SIGINT

# Exit if pacman is not found
if ! command -v pacman &>/dev/null; then
  echo >&2 "cannot find pacman."
  exit 1
fi

# List of packages to install
pacman_packages=(git stow neovim curl bash-completion pkgfile fish fd the_silver_searcher fzf xdg-utils xclip pandoc diff-so-fancy fasd tree bat htop tldr pass albert ranger w3m imlib2 poppler)

aur_packages=(direnv buku)

function install {
  local manager package opts
  manager="$1"
  package="$2"
  shift 2
  opts=("$@")

  # Do nothing if the package is already installed
  pacman -Q "$package" &>/dev/null && echo "$package is present." && return

  echo "$package might not be present. Attempt to install with ${manager}..."

  # System upgrade
  if [ -z "$sys_upgraded" ]; then
    sudo pacman -Syu
    sys_upgraded=1
  fi

  sudo "$manager" -S "${opts[@]}" "$package"
}

echo "Installing packages from official repo..."
for pac in "${pacman_packages[@]}"; do
  install pacman "$pac"
done

# Install pikaur as AUR helper
if command -v pikaur &>/dev/null; then
  echo "pikaur is present."
else
  echo "pikaur is not present. Installing from AUR..."
  install pacman base-devel "--needed" &&
  mkdir -p ~/.tmp/pikaur &&
  git clone https://aur.archlinux.org/pikaur.git ~/.tmp/pikaur &&
  cd ~/.tmp/pikaur &&
  makepkg -fsri || (echo >&2 "Could not install pikaur. Source in ~/.tmp/pikaur" && exit 1)
  rm -rf ~/.tmp/pikaur
fi

echo "Installing packages from AUR..."
for pac in "${aur_packages[@]}"; do
  install pikaur "$pac"
done

echo "Done."
