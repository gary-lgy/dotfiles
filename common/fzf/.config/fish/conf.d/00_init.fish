function is_mac
  uname | grep -q "Darwin"
end

if is_mac
  set -gx PATH "/usr/local/bin" $PATH

  # GPG
  set -gx GPG_TTY (tty)
end
