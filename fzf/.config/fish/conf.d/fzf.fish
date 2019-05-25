#!/usr/bin/env fish

# Set fzf to use fd by default
set -x FZF_DEFAULT_COMMAND fd -HL
set -x FZF_CTRL_T_COMMAND "command fd -HL . \$dir"
set -x FZF_ALT_C_COMMAND fd -HL -t d
set -x FZF_DEFAULT_OPTS --height=40% --reverse \
  --history=$HOME/.fzf_history \
  --bind=ctrl-n:down,ctrl-p:up \
  --bind=ctrl-alt-n:next-history,ctrl-alt-p:previous-history \
  --bind=ctrl-k:kill-line \
  --bind=ctrl-v:page-down,alt-v:page-up \
  --bind=alt-n:preview-down,alt-p:preview-up \
  --bind=alt-a:select-all

# Keybindings
function fzf_custom_key_bindings -d 'Set up fzf custom key bindings for fish'

  function fzf-cd-edit-open-widget -d 'Choose files and directories with fzf and cd, edit, or open them'
    # where and what to search
    set loc "$argv[1]"
    set query "$argv[2..-1]"

    # keys to use in fzf to choose the desired action
    set cd_key alt-c
    set edit_key alt-e
    set open_key alt-o

    # command used for preview
    set preview_cmd "echo -e \"\033[1;33m{}\033[0m\"; \
                     file -biL {} | grep -q \".*text\|directory.*\" || \
                     (echo -e \"\nUnable to preview binary file\"; exit); \
                     bat --color=always --paging=never -p {} --line-range=:30 2>/dev/null || \
                     tree -C {}"

    # header message for fzf widget
    set header (echo -n ":: "; \
                set_color -ou purple; echo -n "alt-c"; set_color normal; echo -n " to cd, "; \
                set_color -ou purple; echo -n "alt-e"; set_color normal; echo -n " to edit, "; \
                set_color -ou purple; echo -n "alt-o"; set_color normal; echo -n " to open, "; \
                set_color -ou purple; echo -n "alt-r"; set_color normal; echo -n " to replace query")

    # get fzf output
    set fzf_output ( \
      fd -HL0 --color=always . $loc | \
      fzf-tmux -m -1 -0 --ansi --read0 --print0 -q $query \
      --header=$header \
      --expect=$cd_key,$edit_key,$open_key \
      --bind="alt-r:replace-query" \
      --preview=$preview_cmd \
      --preview-window=right:50%:wrap | \
      string split0 | \
      string escape)

    # exit if nothing is selected (fzf interupted or no match)
    if not set -q fzf_output[2]
      commandline -f repaint
      return 1
    end

    # choose command to use based on the desired action
    set editor (set -q EDITOR; and string replace -r "/.*/(.*)" "\$1" $EDITOR; or echo vim)

    switch "$fzf_output[1]"
    case $cd_key
      set cmd cd
    case $open_key
      set cmd open
    case $edit_key
      set cmd $editor
    case '*' # Enter or anything else
      set -l file $fzf_output[2]
      if test -d "$fzf_output[2]"
        set cmd cd
      else if string match -q "*text*" (file -biL $file)
        set cmd $editor
      else
        set cmd open
      end
    end

    # if the action is cd but target is a file, cd into its parent directory
    if begin test $fzf_output[1] = $cd_key; and test (count $fzf_output[2..-1]) -eq 1; and test -f $fzf_output[2..-1]; end
      set targets (dirname $fzf_output[2..-1])
    else
      set targets $fzf_output[2..-1]
    end

    # put the fullly constructed command on the commandline buffer and execute it
    commandline -- "$cmd $targets"
    commandline -f repaint
    commandline -f execute
  end

  function fzf-bcd-widget -d 'cd backwards'
    pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | fzf-tmux  +m -1 -0 | read -l result
    if [ -n "$result" ]
      commandline -- "cd $result"
      commandline -f repaint
      commandline -f execute
    else
      commandline -f repaint
    end
  end

  # cd into a recent directory (an alternative to the native cdh function)
  function fzf-cd-recent-widget -d 'cd into a recent directory'
    set -l all_dirs $dirprev $dirnext

    if not set -q all_dirs[1]
      set_color red
      echo >&2 'fzf-cd-recent: No previous directories to select. You have to cd at least once.'
      set_color normal
      commandline -f repaint
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
        commandline -- "cd $dir"
        commandline -f repaint
        commandline -f execute
      else
        commandline -f repaint
      end
    end

  end

  # Three keybindings are set up by default
  # ALT-C = cd into subdirectory (overwritten)
  # CTRL-R = command history
  # CTRL-T = paste fzf output to current command

  # Alt-c to invoke fzf-cd-edit-open widget in current directory, Alt-C to invoke it in $HOME
  bind \ec "fzf-cd-edit-open-widget ./ (commandline)"
  bind \eC "fzf-cd-edit-open-widget ~ (commandline)"
  # Alt-x to cd into one of the parent directories
  bind \ex "fzf-bcd-widget"
  # Alt-r to cd into a recent directory
  bind \ev "fzf-cd-recent-widget"
end
