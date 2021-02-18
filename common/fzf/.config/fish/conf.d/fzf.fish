#!/usr/bin/env fish

# Set fzf to use fd by default
set -x FZF_DEFAULT_COMMAND fd -HL
set -x FZF_CTRL_T_COMMAND "command fd -HL . \$dir"
set -x FZF_ALT_C_COMMAND fd -HL -t d
set -x FZF_DEFAULT_OPTS --height=40% --reverse \
  --history=$HOME/.fzf_history \
  --bind=change:top \
  --bind=ctrl-alt-n:next-history,ctrl-alt-p:previous-history \
  --bind=ctrl-n:down,ctrl-p:up \
  --bind=alt-n:page-down,alt-p:page-up \
  --bind=home:top \
  --bind=alt-j:preview-down,alt-k:preview-up \
  --bind=alt-a:select-all
