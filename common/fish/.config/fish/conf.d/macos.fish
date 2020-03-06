if not uname | grep -q "Darwin"
  exit
end

set -gx PATH "/usr/local/bin" $PATH "$HOME/Library/Python/3.7/bin"
