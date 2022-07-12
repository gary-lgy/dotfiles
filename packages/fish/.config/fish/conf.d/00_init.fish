# This is the first file to be sourced in fish's initialisation sequence

function is_mac
  test (uname) = 'Darwin'
end

# Homebrew
if is_mac
    set -l arc (arch)
    if test $arc = "i386"
        eval (/usr/local/bin/brew shellenv)
    else if test $arc = "arm64"
        eval (/opt/homebrew/bin/brew shellenv)
    end
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

fish_add_path $HOME/bin
