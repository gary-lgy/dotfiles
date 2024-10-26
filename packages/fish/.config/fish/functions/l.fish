if command -v eza &>/dev/null
  function l --wraps=exa
    command eza --long --all --binary --group --header --links --icons --hyperlink $argv
  end
else if command -v exa &>/dev/null
  function l --wraps=exa
    command exa --long --all --binary --group --header --links --color-scale $argv
  end
else
  function l --wraps=ls
    command ls -lAh --color=auto
  end
end

