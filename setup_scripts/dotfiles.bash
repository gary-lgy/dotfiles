#!/usr/bin/env bash

# Stow, unstow, or restow dotfiles

normal='\033[0m'     # Reset
success='\033[1;32m' # Green
info='\033[1;34m'    # Blue
header='\033[1;35m'  # Purple
error='\033[1;31m'   # Red

function __stow {
  echo -e "${info}Stowing ${1}${normal}"
  stow --no-folding --dir="$HOME/dotfiles" --target="$HOME" --stow "$1"
}

function __unstow {
  echo -e "${info}Unstowing ${1}${normal}"
  stow --no-folding --dir="$HOME/dotfiles" --target="$HOME" --delete "$1"
}

function __restow {
  echo -e "${info}Restowing ${1}${normal}"
  stow --no-folding --dir="$HOME/dotfiles" --target="$HOME" --restow "$1"
}

if [[ $# -ne 1 || ! $1 =~ ^(un|re)?stow$ ]]; then
  echo -e "${error}Usage: dotfiles ( stow | unstow | restow )${normal}" >&2
  exit 1
fi

case "$1" in
  "stow" )
    echo -e "${header}Starting to stow${normal}"
    fn="__stow"
    ;;
  "unstow" )
    echo -e "${header}Starting to unstow${normal}"
    fn="__unstow"
    ;;
  "restow" )
    echo -e "${header}Starting to restow${normal}"
    fn="__restow"
    ;;
esac

while read -r package; do
  "$fn" "$package"
done < ~/dotfiles/setup_scripts/stow_list.text

echo -e "${success}Done${normal}"
