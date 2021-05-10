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

brew install starship
brew install shellcheck
brew install git-delta
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
brew install federico-terzi/espanso/espanso

brew install --cask rectangle
brew install --cask karabiner-elements
brew install --cask haptickey
brew install --cask iterm2
brew install --cask clipy
brew install --cask iglance
brew install --cask firefox-developer-edition
brew install --cask google-chrome
brew install --cask telegram-desktop
brew install --cask wechat
brew install --cask ferdi
brew install --cask bitwarden
brew install --cask nordvpn
brew install --cask nextcloud
brew install --cask gpg-suite-no-mail

brew install --cask font-fira-code-nerd-font
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-iosevka-nerd-font
