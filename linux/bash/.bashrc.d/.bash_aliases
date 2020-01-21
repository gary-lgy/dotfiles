#!/usr/bin/env bash

# cd ../.. and cd ../../..
alias ...='cd ../..'
alias ....='cd ../../..'

# Always ask for confirmation before removing or overwriting a file
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Enable color support
alias ls='ls --color=auto -F'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Short-hands for ls
alias la='ls -FAx'
# alias ll='ls -lAh'

# Use exa in place of ls
alias ll='exa --long --all --binary --group --header --links --extended --git --color-scale --icons'

# Use bat as less paginator
alias less='bat'

# Use neovim instead of vim
alias vim='nvim'

# Use vim/nvim for view
alias view='vim -R'
