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
set -gx EDITOR nvim
set -gx INTERACTIVE_SHELL "/usr/local/bin/fish"

# starship - prompt
starship init fish | source

# Set LS_COLORS environment variable
if test -f ~/.dircolor
    eval (dircolors -c ~/.dircolors)
end
#}}}

#######################    Package Specific Config    #######################{{{

# direnv
if command -v direnv >/dev/null 2>&1
    direnv hook fish | source
end
#}}}

# thefuck
if command -v thefuck >/dev/null 2>&1
    thefuck --alias | source
end

