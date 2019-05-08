#!/usr/bin/env bash

# Exit if pacman is not found
if ! command -v pacman &>/dev/null; then
  echo >&2 "cannot find pacman."
  exit 1
fi

pacman_install() {
  local package opts
  package="$1"
  shift 1
  opts=("$@")

  # Do nothing if the package is already installed
  command -v "$package" &>/dev/null && echo "$package is present." && return

  echo "$package might not be present. Attempt to install with pacman..."

  # System upgrade
  if [ -z "$sys_upgraded" ]; then
    sudo pacman -Syu
    sys_upgraded=1
  fi

  sudo pacman -S "${opts[@]}" "$package"
}

echo "Installing packages from official repo..."
pacman_packages=(git nvim curl bash-completion fish fd ag fzf xclip diff-so-fancy fasd tree bat htop tldr pass albert)
for pac in "${pacman_packages[@]}"; do
  pacman_install "$pac"
done

# Install pikaur as AUR helper
if command -v pikaur &>/dev/null; then
  echo "pikaur is present."
else
  echo "pikaur is not present. Installing from AUR..."
  pacman_install base-devel "--needed" &&
  mkdir -p ~/.tmp/pikaur &&
  git clone https://aur.archlinux.org/pikaur.git ~/.tmp/pikaur &&
  cd ~/.tmp/pikaur &&
  makepkg -fsri || (echo >&2 "Could not install pikaur. Source in ~/.tmp/pikaur" && exit 1)
  rm -rf ~/.tmp/pikaur
fi

echo "Installing packages from AUR..."
aur_packages=(direnv)
for pac in "${aur_packages[@]}"; do
  pikaur -S "$pac"
done

echo "Done."
