# Set fzf to use fd by default

if not command -v fd >/dev/null 2>&1
    echo "fd not installed!" >2
end

if not command -v fzf >/dev/null 2>&1
    echo "fzf not installed!" >2
end

set -gx FZF_DEFAULT_COMMAND "fd --hidden --follow"
set -gx FZF_CTRL_T_COMMAND "command fd --hidden --follow . \$dir"
set -gx FZF_ALT_C_COMMAND "fd --hidden --follow --type d"
set -gx FZF_DEFAULT_OPTS --height=40% --reverse \
  --history=$HOME/.fzf_history \
  --bind=change:top \
  --bind=ctrl-alt-n:next-history,ctrl-alt-p:previous-history \
  --bind=ctrl-n:down,ctrl-p:up \
  --bind=alt-n:page-down,alt-p:page-up \
  --bind=home:top \
  --bind=alt-j:preview-down,alt-k:preview-up \
  --bind=alt-a:select-all

