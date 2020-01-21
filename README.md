# My Dotfiles

## Configuration files
I have two main machines, one Dell Inspiron running Arch Linux and one MacBook Pro.
I try as much as possible to share configuration between the two machines.

OS-specific configuration files are in `./linux` and `./macos`, while common ones are in `./common`.

The `./dotf` script manages the config files using `stow`.
Run `./dotf -a {stow,delete,restow}` to link, remove, or relink the config files to their appropriate locations.
The script will only symlink the right files based on the OS name returned by `uname`.

## Installing packages
For Linux, run `./linux/setup_scripts/pacman_install.py`.

For Mac, run `./macos/setup_scripts/setup.sh`
