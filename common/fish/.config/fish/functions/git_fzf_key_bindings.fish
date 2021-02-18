function git_fzf_key_bindings
  set git_log "__fzf_git_commits_browser; commandline -f repaint-mode"
  set git_branch "__fzf_git_tags_branches_browser; commandline -f repaint-mode"
  set git_diff "__fzf_git_diff_browser; commandline -f repaint-mode"
  set git_add "__fzf_git_add_selector; commandline -f repaint-mode"

  bind \eg\ec $git_log
  bind \eg\eb $git_branch
  bind \eg\ed $git_diff
  bind \eg\ea $git_add

  if bind -M insert > /dev/null 2>&1
    bind -M insert \eg\ec $git_log
    bind -M insert \eg\eb $git_branche
    bind -M insert \eg\ed $git_diff
    bind -M insert \eg\ea $git_add
  end
end
