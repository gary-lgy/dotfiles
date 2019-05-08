# Use nvim as default text editor
export EDITOR=/usr/bin/nvim

# Include user's gem bin directory in PATH
export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"

# Install global node modules in home directory (applies to both npm and yarn)
export npm_config_prefix=~/.node_modules
export PATH="$PATH:$HOME/.node_modules/bin"

# Include user's bin directories in PATH
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"

# Add nix into PATH
[ -e /home/gary/.nix-profile/etc/profile.d/nix.sh ] && . /home/gary/.nix-profile/etc/profile.d/nix.sh
