#!/bin/bash

set -eux

if ! command -v brew >/dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew analytics off
brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

brew install brew-cask-completion
brew install neovim
brew install tmux
brew install fish
brew install stow

brew install shellcheck
brew install diff-so-fancy
brew install mosh
brew install htop
brew install fd
brew install exa
brew install fasd
brew install ripgrep
brew install fzf
brew install ranger
brew install bat
brew install tldr
brew install direnv

brew cask install rectangle
brew cask install haptickey
brew cask install emacs
brew cask install iterm2
brew cask install clipy
brew cask install iglance
brew cask install firefox-developer-edition
brew cask install google-chrome
brew cask install telegram-desktop
brew cask install wechat
brew cask install ferdi
brew cask install bitwarden
brew cask install nordvpn
brew cask install nextcloud

brew cask install font-fira-code
brew cask install font-sourcecodepro-nerd-font
