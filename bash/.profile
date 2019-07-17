# Start ssh agent
eval "$(ssh-agent)" >/dev/null 2>&1 &

# Use nvim as default text editor
export EDITOR=/usr/bin/nvim

# Use firefox-developer-edition as default web browser
export BROWSER=/usr/bin/firefox-developer-edition

# Terminal emulator
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

# Initialize rbenv
export PATH="$HOME/.rbenv/shims:$PATH"

# Add nix into PATH
[ -e ~/.nix-profile/etc/profile.d/nix.sh ] && . ~/.nix-profile/etc/profile.d/nix.sh

# Source machine-specific profile
[ -f ~/.profile_local ] && source ~/.profile_local
