#!/usr/bin/env bash

# shellcheck disable=SC1090

# Do nothing if not running interactively
[[ $- != *i* ]] && return

########################    General Bash Experience    ##########################
if [[ ${EUID} == 0 ]] ; then
  PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
else
  PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
fi

[ -r /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
[ -r ~/.bash_aliases ] && source ~/.bash_aliases
[ -r ~/.bash_functions ] && source ~/.bash_functions
[ -r ~/.dircolors ] && eval "$(dircolors -b "$HOME"/.dircolors)"

# Enable completions for sudo
complete -cf sudo

######################    Setup Packages    ######################
# fzf
command -v fzf 2>/dev/null 1>&2 && [ -r ~/.fzf.bash ] && source ~/.fzf.bash

# fasd
command -v fasd 2>/dev/null 1>&2 && eval "$(fasd --init auto)"

# direnv
command -v direnv 2>/dev/null 1>&2 && eval "$(direnv hook bash)"

#############################    Bash Options    ##############################
shopt -s autocd
shopt -s cdspell
shopt -s checkjobs
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s expand_aliases
shopt -s failglob
shopt -s globstar
shopt -s histappend
shopt -s lithist
shopt -s progcomp
shopt -s progcomp_alias
