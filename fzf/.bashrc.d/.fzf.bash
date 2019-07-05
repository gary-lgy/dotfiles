#!/usr/bin/env bash

# Check if fzf is installed locally or system-wide
if [[ ! -f /usr/bin/fzf && ! -f /usr/local/bin/fzf ]]; then
  INSTALLED_LOCALLY=1
else
  INSTALLED_LOCALLY=0
fi

# Setup fzf
# ---------
if [[ $INSTALLED_LOCALLY == 1 && ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  export PATH="$PATH:$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
  if [[ $INSTALLED_LOCALLY == 1 ]]; then
    source ~/.fzf/shell/completion.bash 2> /dev/null
  else
    source "/usr/share/fzf/completion.bash" 2> /dev/null
  fi
fi

# Key bindings
# ------------
if [[ $- == *i* ]]; then
  if [[ $INSTALLED_LOCALLY == 1 ]]; then
    source ~/.fzf/shell/key-bindings.bash
  else
    source "/usr/share/fzf/key-bindings.bash"
  fi
fi

# Change default command to use fd instead of find
# ------------
export FZF_DEFAULT_COMMAND="fd --follow --hidden"
export FZF_DEFAULT_OPTS="--height=40% --reverse \
  --history=$HOME/.fzf_history \
  --bind=ctrl-alt-n:next-history,ctrl-alt-p:previous-history \
  --bind=alt-j:down,alt-k:up \
  --bind=ctrl-k:kill-line \
  --bind=ctrl-n:page-down,ctrl-p:page-up \
  --bind=alt-a:select-all"
export FZF_CTRL_T_COMMAND="fd -HL"
export FZF_ALT_C_COMMAND="fd -HL -t d"

# Short-hand commands
# ------------
__fzf_file_helper() {
  local TOOL="$1"
  local LOC="$2"
  local MULTI
  [[ $3 == 0 ]] && MULTI="--no-multi" || MULTI="--multi"
  shift 3
  local QUERY="$*"
  local FILES
  mapfile -t FILES < <(fd --hidden --follow --type file . "$LOC" | \
    fzf --query="$QUERY" "$MULTI" --select-1 --exit-0 "$FZF_DEFAULT_OPTS")
  [[ -n "${FILES[*]}" ]] && "$TOOL" "${FILES[@]}"
}
export -f __fzf_file_helper

# Edit file(s) under the current directory
function e {
  __fzf_file_helper "${EDITOR:-vim}" . 1 "$*"
}
export -f e

# Edit file(s) from anywhere
function ea {
  __fzf_file_helper "${EDITOR:-vim}" "$HOME" 1 "$*"
}
export -f ea

# Find and open files under the current directory using xdg-open
function o {
  __fzf_file_helper open . 1 "$*"
}
export -f o

# Find and open files from anywhere using xdg-open
function oa {
  __fzf_file_helper open "$HOME" 1 "$*"
}
export -f oa

# cd into a subdirectory
function d {
  cd "$(fd --follow --hidden --type directory | fzf +m --query="$*")"
}
export -f d

# cd into any directory under the home directory
function da {
  cd "$(fd --follow --hidden --type directory . "$HOME" | fzf +m --query="$*")"
}
export -f da
