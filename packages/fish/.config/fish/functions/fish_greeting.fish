function fish_greeting
  # Default message
  set -l message "Learn something new every day."
  # Read a random message from a file if it exists
  if test -f ~/greetings.txt
    set message (shuf -n 1 ~/greetings.txt)
  end

  if command -v cowthink 2>/dev/null 1>&2; and command -v lolcat 2>/dev/null 1>&2
    cowthink $message | lolcat -t -S $i
  else
    echo $message
  end
end
