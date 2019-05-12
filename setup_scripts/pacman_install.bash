#!/usr/bin/env bash

RESET='\033[0m'     # Normal
RED='\033[1;31m'    # Error
GREEN='\033[1;32m'  # Success
YELLOW='\033[1;33m' # Warning
BLUE='\033[1;34m'   # Info

trap "echo -e '${RED}Cancelled.${RESET}'; exit 255" SIGINT

# Exit if pacman is not found
if ! command -v pacman &>/dev/null; then
  echo -e >&2 "${RED}cannot find pacman.${RESET}"
  exit 1
fi

# List of packages to install
base=(networkmanager network-manager-applet git neovim stow bash-completion pkgfile xclip tree openssh htop sysstat acpi)
audio=(pulseaudio pulseaudio-alsa alsa-utils)
terminal_emulator=(rxvt-unicode-pixbuf urxvt-perls)
x=(xorg-server xorg-xinit xorg-xset xdg-utils gtk2 gtk3)
productivity=(python python-neovim fish fd the_silver_searcher fzf shellcheck diff-so-fancy fasd bat tldr direnv pandoc texlive-core)
ranger=(ranger poppler)
i3=(i3-gaps i3blocks betterlockscreen compton rofi feh)
fonts=(adobe-source-code-pro-fonts noto-fonts otf-font-awesome ttf-montserrat)
misc=(pass rofi-pass buku buku_run-git)

packages=( "${base[@]}" "${audio[@]}" "${terminal_emulator[@]}" "${x[@]}" "${productivity[@]}" "${ranger[@]}" "${i3[@]}" "${fonts[@]}" "${misc[@]}" )

function install {
  local package="$1"

  # Do nothing if the package is already installed
  pacman -Q "$package" &>/dev/null && echo -e "${GREEN}${package} is present.${RESET}" && return

  echo -e "${YELLOW}${package} is not present.${RESET}"

  # System upgrade
  if [ -z "$sys_upgraded" ]; then
    echo -e "${YELLOW}System upgrade...${RESET}"
    sudo pacman -Syu
    sys_upgraded=1
  fi

  # If the package is in the official repo, install it from there
  # Otherwise, install it from AUR
  pacman -Si "$package" &>/dev/null &&
  echo -e "${BLUE}Installing ${package} from official repo...${RESET}" &&
  sudo pacman -S "$package" --needed ||
  (echo -e "${BLUE}Installing ${package} from AUR...${RESET}" && pikaur -S "$package")
}

# Install pikaur as AUR helper
echo -e "${BLUE}Checking if pikaur is present${RESET}"
if command -v pikaur &>/dev/null; then
  echo -e "${GREEN}pikaur is present.${RESET}"
else
  echo -e "${YELLOW}pikaur is not present. Installing from AUR...${RESET}"
  install base-devel &&
  mkdir -p ~/.tmp/pikaur &&
  git clone https://aur.archlinux.org/pikaur.git ~/.tmp/pikaur &&
  cd ~/.tmp/pikaur &&
  makepkg -fsri || (echo -e >&2 "${RED}Could not install pikaur. Source in ~/.tmp/pikaur${RESET}" && exit 1)
  rm -rf ~/.tmp/pikaur
fi

echo -e "${BLUE}Installing packages...${RESET}"
for pac in "${packages[@]}"; do
  install "$pac"
done

echo -e "${GREEN}Done.${RESET}"
