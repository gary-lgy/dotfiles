# Start ssh agent
eval "$(ssh-agent)" >/dev/null 2>&1 &

# Use nvim as default text editor
export EDITOR=/usr/bin/nvim

# Use firefox-developer-edition as default web browser
export BROWSER=/usr/bin/firefox-developer-edition

# User kitty as terminal emulator
export TERMINAL=/usr/bin/kitty
export TERMCMD="$TERMINAL"

# Use fish as interactive shell
export INTERACTIVE_SHELL=/usr/bin/fish

# Install global node modules in home directory (applies to both npm and yarn)
export npm_config_prefix=~/.node_modules
[ -d ~/.node_modules/bin ] && export PATH="$PATH:$HOME/.node_modules/bin"
[ -d ~/.yarn/bin ]         && export PATH="$PATH:$HOME/.yarn/bin"

# Include user's bin directories in PATH
[ -d ~/bin ]        && export PATH="$PATH:$HOME/bin"
[ -d ~/.local/bin ] && export PATH="$PATH:$HOME/.local/bin"

# ripgrep configuration file path
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# Add nix into PATH
[ -e /home/gary/.nix-profile/etc/profile.d/nix.sh ] && . /home/gary/.nix-profile/etc/profile.d/nix.sh
