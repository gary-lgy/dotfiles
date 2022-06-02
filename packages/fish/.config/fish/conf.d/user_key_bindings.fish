# This function will be executed by fish to bootstrap keybindings
# https://fishshell.com/docs/current/cmds/bind.html
function fish_user_key_bindings
  # Enable default key bindings in insert mode
  fish_default_key_bindings -M insert
  # Enable vi mode without erasing existing bindings
  fish_vi_key_bindings --no-erase

  # Fzf
  if type -q fzf_key_bindings
    fzf_key_bindings
  end

  # git fzf widgets
  bind \eg\ec git_commits_fzf
  bind \eg\eb git_branches_tags_fzf
  if bind -M insert > /dev/null 2>&1
    bind -M insert \eg\ec git_commits_fzf
    bind -M insert \eg\eb git_branches_tags_fzf
  end
end
