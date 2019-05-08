#!/usr/bin/env bash

RESET='\033[0m'          # Reset
GREEN='\033[1;32m'       # Green
BLUE='\033[1;34m'        # Blue
PURPLE='\033[1;35m'      # Purple

echo -e "${PURPLE}Starting cleanup${RESET}"

function __unstow {
  echo -e "${BLUE}Unstowing ${1}${RESET}"
  stow -D --dir="$HOME/dotfiles" "$1"
}

__unstow albert
__unstow bash
__unstow bat
__unstow dircolors
__unstow editorconfig
__unstow fish
__unstow fzf
__unstow git
__unstow ignore
__unstow nvim
__unstow scripts
__unstow tridactyl
__unstow vim

echo -e "${GREEN}Done${RESET}"
