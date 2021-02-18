function fish_user_key_bindings
  # Enable default key bindings in insert mode
  fish_default_key_bindings -M insert
  # Enable vi mode without erasing existing bindings
  fish_vi_key_bindings --no-erase

  # Fzf
  fzf_custom_key_bindings

  # Git
  git_fzf_key_bindings
end
