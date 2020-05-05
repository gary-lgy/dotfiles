#!/bin/bash

set -eux

if ! command -v brew >/dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew analytics off
brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

brew upgrade brew-cask-completion
brew upgrade neovim
brew upgrade tmux
brew upgrade fish
brew upgrade stow

brew upgrade starship
brew upgrade shellcheck
brew upgrade git-delta
brew upgrade mosh
brew upgrade htop
brew upgrade fd
brew upgrade exa
brew upgrade fasd
brew upgrade ripgrep
brew upgrade fzf
brew upgrade ranger
brew upgrade bat
brew upgrade tldr
brew upgrade direnv

brew cask upgrade rectangle
brew cask upgrade karabiner-elements
brew cask upgrade haptickey
brew cask upgrade emacs
brew cask upgrade iterm2
brew cask upgrade clipy
brew cask upgrade iglance
brew cask upgrade firefox-developer-edition
brew cask upgrade google-chrome
brew cask upgrade telegram-desktop
brew cask upgrade wechat
brew cask upgrade ferdi
brew cask upgrade bitwarden
brew cask upgrade nordvpn
brew cask upgrade nextcloud

brew cask upgrade font-firacode-nerd-font
brew cask upgrade font-saucecodepro-nerd-font
brew cask upgrade font-iosevka-nerd-font
