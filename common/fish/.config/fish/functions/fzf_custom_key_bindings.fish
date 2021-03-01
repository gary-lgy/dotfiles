function fzf_custom_key_bindings -d 'Set up fzf custom key bindings for fish'

  function __is_binary
    # Inspired by https://stackoverflow.com/questions/29465612/how-to-detect-invalid-utf8-unicode-binary-in-a-text-file
    grep --quiet --text --invert-match --line-regexp --max-count=1 '.*' $argv
  end

  function fzf-smart-file-widget -d 'Choose files and directories with fzf and cd, edit, or open them'
    # where and what to search
    set loc "$argv[1]"
    set query "$argv[2..-1]"

    # keys to use in fzf to choose the desired action
    set cd_key alt-c
    set edit_key alt-e
    set open_key alt-o

    # command used for preview
    set preview_cmd "echo -e \"\033[1;33m{}\033[0m\"; \
                     if [ -d {} ]; then exa --all --tree --level=1 --color=always {}/; \
                     else bat --color=always --paging=never -p {} --line-range=:30 2>/dev/null; \
                     fi"

    # header message for fzf widget
    set header (echo -n ":: "; \
                set_color -ou purple; echo -n "alt-c"; set_color normal; echo -n " to cd, "; \
                set_color -ou purple; echo -n "alt-e"; set_color normal; echo -n " to edit, "; \
                set_color -ou purple; echo -n "alt-o"; set_color normal; echo -n " to open, "; \
                set_color -ou purple; echo -n "alt-r"; set_color normal; echo -n " to replace query")

    # get fzf output
    set fzf_output ( \
      fd -HL0 --color=always . $loc | \
      fzf-tmux -m -0 --ansi --read0 --print0 -q $query \
      --header=$header \
      --expect=$cd_key,$edit_key,$open_key \
      --bind="alt-r:replace-query" \
      --preview=$preview_cmd \
      --preview-window=right:50%:wrap | \
      string split0)

    # exit if nothing is selected (fzf interrupted or no match)
    if not set -q fzf_output[2]
      commandline -f repaint-mode
      return 1
    end

    set -l key_pressed $fzf_output[1]
    set -l first_file $fzf_output[2]

    # if the action is cd but target is a file, cd into its parent directory
    if begin test $key_pressed = $cd_key; and test (count $fzf_output[2..-1]) -eq 1; and test -f $first_file; end
      set targets (dirname $fzf_output[2])
    else
      set targets $fzf_output[2..-1]
    end

    # Escape the targets
    set targets (string escape $targets)

    # choose command to use based on the desired action
    if set -q EDITOR
      set editor (basename $EDITOR)
    else
      set editor vim
    end

    set cd_command "cd $targets && ll"
    set open_command "open $targets"
    set edit_command "$editor $targets"

    switch $key_pressed
    case $cd_key
      set cmd $cd_command
    case $open_key
      set cmd $open_command
    case $edit_key
      set cmd $edit_command
    case '*' # For any other key pressed, DWIM
      if test -d $first_file
        set cmd $cd_command
      else if __is_binary $first_file
        set cmd $open_command
      else
        set cmd $edit_command
      end
    end

    # put the fullly constructed command on the commandline buffer and execute it
    set targets (string escape $targets) # Escape the targets first
    commandline -- $cmd
    commandline -f repaint-mode
    commandline -f execute
  end

  function fzf-cd-backwards-widget -d 'cd backwards'
    pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | fzf-tmux  +m -1 -0 | read -l result
    if [ -n "$result" ]
      commandline -- "cd $result && ll"
      commandline -f repaint-mode
      commandline -f execute
    else
      commandline -f repaint-mode
    end
  end

  # cd into a recent directory (an alternative to the native cdh function)
  function fzf-cd-recent-widget -d 'cd into a recent directory'
    set -l all_dirs $dirprev $dirnext

    if not set -q all_dirs[1]
      set_color red
      echo >&2 'fzf-cd-recent: No previous directories to select. You have to cd at least once.'
      set_color normal
      commandline -f repaint-mode
      return 1
    else
      # Reverse and only retain unique directories
      set -l uniq_dirs
      for dir in $all_dirs[-1..1]
        if not contains $dir $uniq_dirs
          set -a uniq_dirs $dir
        end
      end

      string join0 $uniq_dirs | fzf-tmux  +m -1 -0 --read0 | read dir
      if [ -n "$dir" ]
        commandline -- "cd $dir && ll"
        commandline -f repaint-mode
        commandline -f execute
      else
        commandline -f repaint-mode
      end
    end

  end

  # fzf completion and print selection back to commandline'
  function fzf-autocomplete-widget
    # As of 2.6, fish's "complete" function does not understand
    # subcommands. Instead, we use the same hack as __fish_complete_subcommand and
    # extract the subcommand manually.
    set -l cmd (commandline -co) (commandline -ct)
    switch $cmd[1]
      case env sudo
        for i in (seq 2 (count $cmd))
          switch $cmd[$i]
            case '-*'
            case '*=*'
            case '*'
              set cmd $cmd[$i..-1]
              break
          end
        end
    end
    set cmd (string join -- ' ' $cmd)

    set -l complist (complete -C$cmd)
    set -l result
    string join -- \n $complist | sort | eval (__fzfcmd) -m --select-1 --exit-0 --header '(commandline)' | cut -f1 | while read -l r; set result $result $r; end

    if test (count $result) -eq 0
      # if nothing is selected, just exit
      commandline -f repaint-mode
      return
    end

    set prefix (string sub -s 1 -l 1 -- (commandline -t))
    for i in (seq (count $result))
      set -l r $result[$i]
      switch $prefix
        case "'"
          commandline -t -- (string escape -- $r)
        case '"'
          if string match '*"*' -- $r >/dev/null
            commandline -t --  (string escape -- $r)
          else
            commandline -t -- '"'$r'"'
          end
        case '~'
          commandline -t -- (string sub -s 2 (string escape -n -- $r))
        case '*'
          commandline -t -- (string escape -n -- $r)
      end
      [ $i -lt (count $result) ]; and commandline -i ' '
    end

    commandline -f repaint-mode
  end

  ##############################################################

  # Default key-bindings
  fzf_key_bindings

  # Alt-c to invoke fzf-cd-edit-open widget in current directory, Alt-C to invoke it in $HOME
  bind \ec "fzf-smart-file-widget ./ (commandline)"
  bind \eC "fzf-smart-file-widget ~ (commandline)"
  # Alt-x to cd into one of the parent directories
  bind \ex fzf-cd-backwards-widget
  # Alt-r to cd into a recent directory
  bind \ev fzf-cd-recent-widget
  # Alt-o to select an auto-completion
  bind \eo fzf-autocomplete-widget

  # Create the same bindings in insert mode as well
  if bind -M insert > /dev/null 2>&1
    bind -M insert \ec "fzf-smart-file-widget ./ (commandline)"
    bind -M insert \eC "fzf-smart-file-widget ~ (commandline)"
    bind -M insert \ex fzf-cd-backwards-widget
    bind -M insert \ev fzf-cd-recent-widget
    bind -M insert \eo fzf-autocomplete-widget
  end
end
