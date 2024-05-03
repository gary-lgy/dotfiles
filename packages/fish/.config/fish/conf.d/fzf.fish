# only apply for interactive shell
if not status --is-interactive
    exit
end

if not command -v fzf >/dev/null 2>&1
    echo "fzf not installed!" >&2
    exit
end

set -gx FZF_DEFAULT_OPTS --height=40% --reverse \
  --history=$HOME/.fzf_history \
  --bind=change:top \
  --bind=ctrl-alt-n:next-history,ctrl-alt-p:previous-history \
  --bind=ctrl-n:down,ctrl-p:up \
  --bind=alt-n:page-down,alt-p:page-up \
  --bind=home:top \
  --bind=alt-j:preview-down,alt-k:preview-up \
  --bind=alt-a:select-all

# Set fzf to use fd if it is available
if command -v fd >/dev/null 2>&1
    set fd_bin fd
else if command -v fdfind >/dev/null 2>&1
    # On Debian fd is fdfind
    set fd_bin fdfind
else
    echo "fd not installed! falling back to slow search" >&2
    exit
end

set -gx FZF_DEFAULT_COMMAND "$fd_bin --hidden --follow"
set -gx FZF_CTRL_T_COMMAND "command $fd_bin --hidden --follow . \$dir"
set -gx FZF_ALT_C_COMMAND "$fd_bin --hidden --follow --type d"
