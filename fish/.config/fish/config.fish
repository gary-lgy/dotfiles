#!/usr/bin/env fish

not status --is-interactive; and exit

######################    Fisher    #######################{{{
# Use fisher for package management
if not functions -q fisher
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  fish -c fisher
end

# Install fisher packages in ~/.config/fish/fisher
set -g fisher_path ~/.config/fish/fisher

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end
#}}}

#######################    Package Specific Config    #######################{{{
# Set LS_COLORS environment variable
eval (dircolors -c ~/.dircolors)

# Set up fzf
test -f ~/.config/fish/fzf.fish; and source ~/.config/fish/fzf.fish

# Hook direnv into fish
direnv hook fish | source
#}}}

######################    Abbreviations    #######################{{{
abbr --global cp cp -i
abbr --global mv mv -i
abbr --global rm rm -i
abbr --global view nvim -R
abbr --global la ls -FAhx
abbr --global ll ls -lAhF
abbr --global gs git status
abbr --global gl git log --pretty=oneline -5
#}}}

#####################    Bobthefish Theme Config #####################{{{
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_git_worktree_support no
set -g theme_display_vagrant yes
set -g theme_display_docker_machine yes
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_ruby yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi yes
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g theme_show_exit_status yes
set -g theme_color_scheme gruvbox
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 0
set -g theme_newline_cursor yes
#}}}

######################    Colored Man Pages    ########################{{{
set -xU LESS_TERMCAP_md (printf "\e[0;35m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")
#}}}

# Setup custom key bindings
test -r ~/.config/fish/functions/fish_user_key_bindings.fish; and fish_user_key_bindings
