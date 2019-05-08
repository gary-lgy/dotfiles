#!/usr/bin/env bash

RESET='\033[0m'          # Text Reset
GREEN='\033[1;32m'       # Green
BLUE='\033[1;34m'        # Blue
PURPLE='\033[1;35m'      # Purple

echo -e "${PURPLE}Starting to stow${RESET}"

function __stow {
  echo -e "${BLUE}Stowing ${1}${RESET}"
  stow --dir="$HOME/dotfiles" "$1"
}

__stow albert
__stow bash
__stow bat
__stow dircolors
__stow editorconfig
__stow fish
__stow fzf
__stow git
__stow ignore
__stow nvim
__stow scripts
__stow tridactyl
__stow vim

echo -e "${GREEN}Done${RESET}"
