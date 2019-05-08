# My Dotfiles

After some experimenting, I finally decided that `git + stow` might be the best
approach to manage dotfiles. This repo uses that approach.

## Setup
1. Install official packages by running  
  `bash pacman_install.bash`, or  
  `bash apt_install.bash`  
2. Install nix packages by running  
  `bash nix_install.bash`  
  Make sure to specify what packages to install first.
3. Symlink dotfiles with stow by running
   `bash setup.bash`.

## Cleanup
To remove all symlinks, run `cleanup.bash`.
