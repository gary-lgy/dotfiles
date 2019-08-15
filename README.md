# My Dotfiles

After some experimenting, I finally decided that `git + stow` might be the best
approach to manage dotfiles. This repo uses that approach.

## Setup
1. Install packages by running  
  `python pacman_install.py`  
2. Symlink dotfiles with stow by running  
   `dotf stow`.

## Cleanup
To remove all symlinks, run `dotf unstow`.

## Update
To update symlinks, run `dotf restow`
