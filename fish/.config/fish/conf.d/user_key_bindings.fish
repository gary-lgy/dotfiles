function fish_user_key_bindings
  fzf_key_bindings
  fzf_custom_key_bindings

  bind \eg\ec "__fzf_git_commits_browser; commandline -f repaint"
  bind \eg\eb "__fzf_git_tags_branches_browser; commandline -f repaint"
  bind \er "ranger; commandline -f  repaint"
  bind \et "tmux; commandline -f repaint"
end
