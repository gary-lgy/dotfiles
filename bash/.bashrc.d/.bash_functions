#!/usr/bin/env bash

# Exclude some rarely used directories for ag search
ag() {
  command ag --path-to-ignore ~/.ignore --follow "$@"
}
export -f ag

# Short-hand for 'git log --pretty=oneline -n'
gl() {
  # print git log, each log per line
  # default to printing 5 lines of logs
  git log --pretty=oneline "${1:--5}"
}
export -f gl

# Extension to the 'open' command that can take multiple arguments
open() {
  if [ "$#" -eq 0 ]; then
    echo >&2 'USAGE: open FILES'
    exit 1
  fi
  for FILE in "$@"; do
    [[ -e $FILE ]] && xdg-open "$FILE" || echo >&2 "Error when opening file: $FILE does not exist"
  done
}
export -f open

# For colored man pages
man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}
export -f man
