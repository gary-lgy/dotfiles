if status --is-interactive

  if test (less --version | grep -E '^less [[:digit:]]+' | cut -d' ' -f2) -ge 543
    # enable `--mouse` only if less is new enough to support it
    set -gx LESS '--RAW-CONTROL-CHARS --mouse'
  else
    set -gx LESS '--RAW-CONTROL-CHARS'
  end

  # Check fisher
  if not functions -q fisher
    echo "Fisher not installed!!!" >&2
    echo "https://github.com/jorgebucaran/fisher" >&2
  end

  # direnv
  if command -v direnv >/dev/null 2>&1
    direnv hook fish | source
  end

  # thefuck
  if command -v thefuck >/dev/null 2>&1
    thefuck --alias | source
  end

  # # starship - prompt
  # Starship is slow in a large git repo
  # https://github.com/starship/starship/issues/301
  # if command -v starship >/dev/null 2>&1
  #   starship init fish | source
  # end

  # asdf
  if command -v asdf 2>/dev/null 1>&2
    if is_mac
      source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish
    end
  else if test -f ~/.asdf/asdf.fish
    source ~/.asdf/asdf.fish
  end

  # iTerm shell integration
  test -e /Users/bytedance/.iterm2_shell_integration.fish ; and source /Users/bytedance/.iterm2_shell_integration.fish ; or true
end
