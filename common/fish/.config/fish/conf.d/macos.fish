if not uname | grep -q "Darwin"
  exit
end

# pip bin
set -gx PATH "/usr/local/bin" $PATH "$HOME/Library/Python/3.7/bin"

# asdf
if command -v asdf 2>/dev/null 1>&2
  source "/usr/local/opt/asdf/asdf.fish"
end
