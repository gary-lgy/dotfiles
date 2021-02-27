# My Dotfiles

I have two main machines, a Dell Inspiron running Arch Linux and a MacBook Pro.
I try as much as possible to share configuration between the two machines.

## Configuration files

OS-specific configuration files are in `./linux` and `./darwin`; shared ones are in `./common`.

The `./dotf` script manages the config files by symlinking them using `stow`.

Run
```bash
./dotf -a {stow,delete,restow}
```
to link, remove, or relink the config files to their appropriate locations.
The script will only symlink the right files based on the OS name returned by `uname`.

## Package Installation

For Arch Linux, run `./linux/setup_scripts/pacman_install.py`.

For macOS, run `./macos/setup_scripts/setup.sh`

# License

MIT
