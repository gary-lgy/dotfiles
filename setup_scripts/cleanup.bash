#!/usr/bin/env bash

RESET='\033[0m'          # Reset
GREEN='\033[1;32m'       # Green
BLUE='\033[1;34m'        # Blue
PURPLE='\033[1;35m'      # Purple

echo -e "${PURPLE}Starting cleanup${RESET}"

function __unstow {
  echo -e "${BLUE}Unstowing ${1}${RESET}"
  stow -D --no-folding --dir="$HOME/dotfiles" "$1"
}

__unstow bash
__unstow bat
__unstow buku_run
__unstow dircolors
__unstow dunst
__unstow editorconfig
__unstow fish
__unstow fontconfig
__unstow fzf
__unstow git
__unstow gtk-3.0
__unstow i3
__unstow i3blocks
__unstow ignore
__unstow nvim
__unstow ranger
__unstow rofi-pass
__unstow scripts
__unstow tridactyl
__unstow vim
__unstow x

echo -e "${GREEN}Done${RESET}"
