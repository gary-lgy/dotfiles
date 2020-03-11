function fish_greeting
  set -l message "Learn something new every day."
  if command -v cowthink 2>/dev/null 1>&2; and command -v lolcat 2>/dev/null 1>&2
    cowthink $message | lolcat -t -S $i
  else
    echo $message
  end
end
