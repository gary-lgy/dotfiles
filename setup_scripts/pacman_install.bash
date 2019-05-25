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
base=(networkmanager network-manager-applet git neovim stow bash-completion pkgfile tree openssh htop sysstat acpi gparted curl)
audio=(pulseaudio pulseaudio-alsa alsa-utils)
terminal_emulator=(kitty python-pillow pygmentize)
desktop=(xorg-server xorg-xinit xorg-xrdb xorg-xset xdg-utils perl-file-mimeinfo acpilight gtk2 gtk3 flameshot dunst feh)
utilities=(python python-neovim fish fd the_silver_searcher ripgrep fzf ranger xclip shellcheck-static diff-so-fancy fasd bat tldr direnv unzip pass udiskie expect nodejs npm yarn)
documents=(zathura zathura-pdf-poppler pandoc-bin texlive-core)
# libreoffice
i3=(i3-gaps i3blocks betterlockscreen compton)
fonts=(adobe-source-code-pro-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji otf-font-awesome)
web_browsing=(firefox buku)
rofi=(rofi rofimoji-git rofi-pass buku_run-git rofi-greenclip)

packages=( "${base[@]}" "${audio[@]}" "${terminal_emulator[@]}" "${desktop[@]}" "${utilities[@]}" "${documents[@]}" "${rofi[@]}" "${i3[@]}" "${fonts[@]}" "${password[@]}" "${web_browsing[@]}" )

function install {
  local package="$1"

  # Do not reinstall if the package is already installed
  pacman -Q "$package" &>/dev/null &&
  echo -e "${GREEN}${package} is present.${RESET}" &&
  { pacman -Qi "${package}" | grep -F "Install Reason" | grep -q "dependency for another package" &&
    sudo pacman -D --asexplicit "$package";
    return;
  }

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
  { echo -e "${BLUE}Installing ${package} from AUR...${RESET}"; pikaur -S "$package"; }
}

# Install pikaur as AUR helper
echo -e "${BLUE}Checking if pikaur is present${RESET}"
if command -v pikaur &>/dev/null; then
  echo -e "${GREEN}pikaur is present.${RESET}"
else
  echo -e "${YELLOW}pikaur is not present. Installing from AUR...${RESET}"
  mkdir -p ~/.tmp/pikaur &&
  git clone https://aur.archlinux.org/pikaur.git ~/.tmp/pikaur &&
  cd ~/.tmp/pikaur &&
  makepkg -fsri || { echo -e >&2 "${RED}Could not install pikaur. Source in ~/.tmp/pikaur${RESET}"; exit 1; }
  rm -rf ~/.tmp/pikaur
fi

echo -e "${BLUE}Installing packages...${RESET}"
for pac in "${packages[@]}"; do
  install "$pac"
done

echo -e "${GREEN}Done.${RESET}"
