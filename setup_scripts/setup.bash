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

while read -r package; do
  __stow "$package"
done < ~/dotfiles/setup_scripts/stow_list.text

echo -e "${GREEN}Done${RESET}"
