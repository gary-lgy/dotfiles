if status --is-interactive

  set -gx LESS '--RAW-CONTROL-CHARS --mouse'

  # Check fisher
  if not functions -q fisher
    echo "Fisher not installed!!!" >&2
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
      source "/usr/local/opt/asdf/libexec/asdf.fish"
    end
  end

end
