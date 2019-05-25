#!/usr/bin/env bash

# Always ask for confirmation before removing or overwriting a file
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Enable color support
alias ls='ls --color=auto -Fx'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Short-hands for ls
alias la='ls -A'
alias ll='ls -lAh'

# Use bat as less paginator
alias less='bat'

# Use neovim instead of vim
alias vim='nvim'

# Use vim/nvim for view
alias view='vim -R'
