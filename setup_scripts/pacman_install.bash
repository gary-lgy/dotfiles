#!/bin/bash

RESET='\033[0m'     # Normal
RED='\033[1;31m'    # Error
GREEN='\033[1;32m'  # Success
YELLOW='\033[1;33m' # Warning
BLUE='\033[1;34m'   # Info

trap "echo -e '${RED}Cancelled.${RESET}'; exit 255" SIGINT

# Exit if pacman is not found
if ! command -v pacman &>/dev/null; then
  echo -e "${RED}cannot find pacman.${RESET}" 1>&2
  exit 1
fi

# List of packages to install
base=(git neovim python python-pynvim neovim-symlinks emacs stow curl)
maintenance=(pkgfile pacman-contrib expac pacmatic lostfiles)
monitoring=(htop sysstat acpi net-tools lsof ncdu)
cli_utils=(bash-completion openssh tree exa xclip fish fd ripgrep fzf ranger w3m fasd bat thefuck tldr direnv expect tmux)
# audio=(pulseaudio pulseaudio-alsa alsa-utils)
gui=(xorg-server xorg-xinit xorg-xrdb xorg-xset xorg-xrandr gtk2 gtk3)
fonts=(adobe-source-code-pro-fonts ttf-iosevka otf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji otf-font-awesome nerd-fonts-source-code-pro)
# Window manager and packages that come with most DEs but do not come with WMs
WM=(i3-gaps i3blocks betterlockscreen compton networkmanager network-manager-applet gparted acpilight dunst eom feh udiskie)
terminal_emulator=(kitty termite)
launcher=(rofi rofi-dmenu rofimoji rofi-pass buku_run-git rofi-greenclip)
gui_utils=(xdg-utils perl-file-mimeinfo desktop-file-utils sxhkd flameshot)
misc_utils=(pass gnome-keyring unzip buku nextcloud-client bitwarden-bin)
coding=(ctags shellcheck-static diff-so-fancy zeal)
documents=(zathura zathura-pdf-poppler pandoc-bin texlive-core texlive-latexextra texlive-science words hunspell hunspell-en_GB)
browser=(firefox-developer-edition)
input_methods=(fcitx-im fcitx-configtool fcitx-googlepinyin)

optional=(libreoffice-fresh syncthing-gtk rambox telegram-desktop electronic-wechat evince nordvpn-bin wireguard-tools wireguard-arch)

packages=( "${base[@]}" "${maintenance[@]}" "${monitoring[@]}" "${cli_utils[@]}" "${audio[@]}" "${gui[@]}" "${fonts[@]}" "${WM[@]}" "${terminal_emulator[@]}" "${launcher[@]}" "${gui_utils[@]}" "${misc_utils[@]}" \
  "${coding[@]}" "${documents[@]}" "${browser[@]}" "${input_methods[@]}")

function install_group {
  pacman -Sg "$1" &>/dev/null || return 1
  local group="$1"

  echo -e "${BLUE}${group} is a group...${REEST}"
  for package in $(pacman -Sg "$group" | awk '{print $2}'); do
    install_package "$package"
  done
}

function install_package {
  local package="$1"

  # Do not reinstall if the package is already installed
  if pacman -Q "$package" &>/dev/null; then
    echo -e "${GREEN}${package} is present.${RESET}"
    # Change install reason to explicitly installed if it was installed as a dependency previously
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

function install {
  # Handle the case where the argument is a group
  # Otherwise, install it as a package
  install_group "$1" || install_package "$1"
}

# Install pikaur as AUR helper
echo -e "${BLUE}Checking if pikaur is present${RESET}"
if command -v pikaur &>/dev/null; then
  echo -e "${GREEN}pikaur is present.${RESET}"
else
  echo -e "${YELLOW}pikaur is not present. Installing from AUR...${RESET}"
  mkdir -p ~/src/pikaur &&
  git clone https://aur.archlinux.org/pikaur.git ~/src/pikaur &&
  cd ~/src/pikaur &&
  makepkg -fsri || { echo -e "${RED}Could not install pikaur. Source in ~/src/pikaur${RESET}" 1>&2; exit 1; }
  rm -rf ~/src/pikaur
fi

echo -e "${BLUE}Installing packages...${RESET}"
for pac in "${packages[@]}"; do
  install "$pac"
done

echo -e "${GREEN}Done.${RESET}"
echo -e "${BLUE}You may also want to install ${optional[*]}.${RESET}"
