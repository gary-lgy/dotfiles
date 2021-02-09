function fish_user_key_bindings
  fzf_key_bindings # Default key-bindings
  fzf_custom_key_bindings # Custom key-bindings

  bind \eg\ec "~/bin/__fzf_git_commits_browser; commandline -f repaint"
  bind \eg\eb "~/bin/__fzf_git_tags_branches_browser; commandline -f repaint"
  bind \eg\ed "~/bin/__fzf_git_diff_browser; commandline -f repaint"
  bind \eg\ea "~/bin/__fzf_git_add_selector; commandline -f repaint"
  bind \er "ranger; commandline -f repaint"
  bind \et "tmux; commandline -f repaint"
  bind \co "fzf_complete"
end
