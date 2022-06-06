# This is the first file to be sourced in fish's initialisation sequence

function is_mac
  test (uname) = 'Darwin'
end

# Homebrew
if is_mac
    eval (/usr/local/bin/brew shellenv)
end

# Environment variables
if command -v "$HOMEBREW_PREFIX/bin/nvim" >/dev/null 2>&1
    set -gx EDITOR "$HOMEBREW_PREFIX/bin/nvim"
end

if command -v "$HOMEBREW_PREFIX/bin/fish" >/dev/null 2>&1
    set -gx INTERACTIVE_SHELL "$HOMEBREW_PREFIX/bin/fish"
end

if command -v "$HOMEBREW_PREFIX/bin/less" >/dev/null 2>&1
    set -gx PAGER "$HOMEBREW_PREFIX/bin/less" # On MacOS, the default less is /usr/bin/less, which is outdated
end

