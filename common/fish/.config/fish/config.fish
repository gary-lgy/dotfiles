#!/usr/bin/env fish

######################    Fisher    #######################{{{
if status --is-interactive; and not functions -q fisher
  echo "Fisher not installed, installing Fisher first"
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end
#}}}

#######################    General Config    #######################{{{

# Environment variables
set -gx EDITOR (which nvim)
set -gx INTERACTIVE_SHELL (which fish)

# Machine local config
set -l fish_local_config $HOME/.config/fish/config.local.fish
if test -f $fish_local_config
  source $fish_local_config
end
#}}}

#######################    Package Specific Config    #######################{{{

if status --is-interactive

  # direnv
  if command -v direnv >/dev/null 2>&1
    direnv hook fish | source
  end

  # thefuck
  if command -v thefuck >/dev/null 2>&1
    thefuck --alias | source
  end

  # starship - prompt
  if command -v starship >/dev/null 2>&1
    starship init fish | source
  end

  # asdf
  if command -v asdf 2>/dev/null 1>&2
    if is_mac
      source "/usr/local/opt/asdf/asdf.fish"
    end
  end

  # GPG
  if is_mac
    set -gx GPG_TTY (tty)
  end
end

#}}}

# vim: fdm=marker
