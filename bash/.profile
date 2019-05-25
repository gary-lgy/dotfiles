# Start ssh agent
eval "$(ssh-agent)" >/dev/null 2>&1 &

# Use nvim as default text editor
export EDITOR=/usr/bin/nvim

# # Install global node modules in home directory (applies to both npm and yarn)
# export npm_config_prefix=~/.node_modules
# export PATH="$PATH:$HOME/.node_modules/bin"

# Include user's bin directories in PATH
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"

# Add nix into PATH
[ -e /home/gary/.nix-profile/etc/profile.d/nix.sh ] && . /home/gary/.nix-profile/etc/profile.d/nix.sh
