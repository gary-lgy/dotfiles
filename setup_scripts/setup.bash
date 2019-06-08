#!/usr/bin/env bash

RESET='\033[0m'          # Text Reset
GREEN='\033[1;32m'       # Green
BLUE='\033[1;34m'        # Blue
PURPLE='\033[1;35m'      # Purple

echo -e "${PURPLE}Starting to stow${RESET}"

function __stow {
  echo -e "${BLUE}Stowing ${1}${RESET}"
  stow --no-folding --dir="$HOME/dotfiles" "$1"
}

__stow asdf
__stow bash
__stow bat
__stow buku_run
__stow dircolors
__stow dunst
__stow editorconfig
__stow fish
__stow fontconfig
__stow fzf
__stow git
__stow gtk-3.0
__stow i3
__stow i3blocks
__stow ignore
__stow kitty
__stow misc
__stow nvim
__stow ranger
__stow rofi-pass
__stow scripts
__stow sxhkd
__stow tridactyl
__stow vim
__stow x

echo -e "${GREEN}Done${RESET}"
