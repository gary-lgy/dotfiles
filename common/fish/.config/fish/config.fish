#!/usr/bin/env fish

not status --is-interactive; and exit

######################    Fisher    #######################{{{
# Install fisher packages in ~/.config/fish/fisher
set -g fisher_path ~/.config/fish/fisher

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

if not functions -q fisher
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  fish -c fisher
end

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
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

# ls colors
if test -f ~/.dircolor
  eval (dircolors -c ~/.dircolors)
end

#}}}

# vim: fdm=marker
