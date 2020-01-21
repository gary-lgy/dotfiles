function v --wraps f -d 'Open a file from fasd using $EDITOR'
  f -e $EDITOR $argv
end
