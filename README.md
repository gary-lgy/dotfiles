# My Dotfiles

I have two main machines, a Dell Inspiron running Arch Linux and a MacBook Pro.
I try as much as possible to share configuration between the two machines.

## Configuration files
OS-specific configuration files are in `./linux` and `./darwin`, while common ones are in `./common`.

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

## Some Packages I Use (huge thanks to the authors)

| Package Name            | Category                 | Linux | macOS |
| ----------------------- | ------------------------ | ----- | ----- |
| fish                    | shell                    | ✅    | ✅    |
| ripgrep                 | CLI tools                | ✅    | ✅    |
| fzf                     | CLI tools                | ✅    | ✅    |
| fd                      | CLI tools                | ✅    | ✅    |
| fasd                    | CLI tools                | ✅    | ✅    |
| tldr                    | CLI tools                | ✅    | ✅    |
| git-delta               | CLI tools                | ✅    | ✅    |
| bat                     | CLI tools                | ✅    | ✅    |
| neovim                  | text editor              | ✅    | ✅    |
| tmux                    | terminal multiplexer     | ✅    | ✅    |
| ranger                  | file manager             | ✅    | ✅    |
| starship                | shell prompt             | ✅    | ✅    |
| asdf                    | language version manager | ✅    | ✅    |
| vimium-ff               | browser extension        | ✅    | ✅    |
| Nextcloud (self-hosted) | cloud storage            | ✅    | ✅    |
| buku                    | bookmark manager         | ✅    |       |
| polybar                 | status bar               | ✅    |       |
| i3-gaps                 | window manager           | ✅    |       |
| xcfe                    | desktop environment      | ✅    |       |
| rofi                    | launcher                 | ✅    |       |
| kitty                   | terminal emulator        | ✅    |       |
| iTerm2                  | terminal emulator        |       | ✅    |
| Rectangle               | window manager           |       | ✅    |
| Karabiner-Elements      | keyboard customization   |       | ✅    |
| iGlance                 | resource monitor         |       | ✅    |

# License
MIT
