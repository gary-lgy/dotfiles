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
base=(git neovim python python-neovim stow bash-completion openssh curl)
cli_utils=(pkgfile tree xclip fish fd the_silver_searcher ripgrep fzf ranger fasd bat thefuck tldr direnv expect)
monitoring=(htop sysstat acpi net-tools)
audio=(pulseaudio pulseaudio-alsa alsa-utils)
gui=(xorg-server xorg-xinit xorg-xrdb xorg-xset xorg-xrandr gtk2 gtk3)
fonts=(adobe-source-code-pro-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji otf-font-awesome nerd-fonts-source-code-pro)
# Window manager and packages that come with most DEs but do not come with WMs
WM=(i3-gaps i3blocks betterlockscreen compton networkmanager network-manager-applet gparted acpilight dunst imv udiskie)
terminal_emulator=(kitty python-pillow pygmentize)
launcher=(rofi rofi-dmenu rofimoji-git rofi-pass buku_run-git rofi-greenclip)
gui_utils=(xdg-utils perl-file-mimeinfo desktop-file-utils sxhkd flameshot feh)
misc_utils=(pass unzip buku nextcloud-client)
coding=(shellcheck-static diff-so-fancy nodejs npm yarn)
documents=(zathura zathura-pdf-poppler pandoc-bin texlive-core)
web_browsing=(firefox-developer-edition)

pending=(libreoffice-fresh joplin)

packages=( "${base[@]}" "${cli_utils[@]}" "${monitoring[@]}" "${audio[@]}" "${gui[@]}" "${fonts[@]}" "${WM[@]}" "${terminal_emulator[@]}" "${launcher[@]}" "${gui_utils[@]}" "${misc_utils[@]}" \
  "${coding[@]}" "${documents[@]}" "${web_browsing[@]}" )

function install {
  local package="$1"

  # Do not reinstall if the package is already installed
  if pacman -Q "$package" &>/dev/null; then
    echo -e "${GREEN}${package} is present.${RESET}"
    if pacman -Qi "${package}" | grep -F "Install Reason" | grep -q "dependency for another package"; then
      echo -e "${BLUE}Changing install reason of ${package} to explicit${RESET}"
      sudo pacman -D --asexplicit "$package"
    fi
    return
  fi

  echo -e "${YELLOW}${package} is not present.${RESET}"

  # System upgrade
  [ -z "$sys_upgraded" ] && { echo -e "${YELLOW}System upgrade...${RESET}"; sudo pacman -Syu && sys_upgraded=1; }

  # If the package is in the official repo, install it from there
  # Otherwise, install it from AUR
  if pacman -Si "$package" &>/dev/null; then
    echo -e "${BLUE}Installing ${package} from official repo...${RESET}"
    sudo pacman -S "$package" --needed
  else
    echo -e "${BLUE}Installing ${package} from AUR...${RESET}"
    pikaur -S "$package"
  fi
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
echo -e "${BLUE}You may want to install ${pending[*]} yourself.${RESET}"
