# Start ssh agent
eval "$(ssh-agent)" >/dev/null 2>&1 &

# Environment Variables
export EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/firefox-developer-edition
export TERMINAL=/usr/bin/kitty
export TERMCMD="$TERMINAL"
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

# Source machine-specific profile
[ -f ~/.profile_local ] && source ~/.profile_local
