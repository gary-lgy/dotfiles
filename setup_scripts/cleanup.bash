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

while read -r package; do
  __unstow "$package"
done < ~/dotfiles/setup_scripts/stow_list.text

echo -e "${GREEN}Done${RESET}"
