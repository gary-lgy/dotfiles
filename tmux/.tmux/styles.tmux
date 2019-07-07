#!/bin/bash

# Tmux status bar
# +odified from https://github.com/wfxr/tmux-power/blob/master/tmux-power.tmux
# ------------------------------------------------------------------------------

set -e

tmux set -g status-interval 1
tmux set -g status-left-length  100
tmux set -g status-right-length 50

# Colors
# -------------------------------------------------------------
# TC: theme color.
TC=colour214

# GR: different shades of gray
GR0=colour239
GR1=colour241
GR2=colour251

BG=colour236

# Segment styles
level0="#[bg=$TC,fg=$BG,bold]"
level1="#[bg=$GR0,fg=$TC,bold]"

# Separator styles
separator0="#[bg=$GR0,fg=$TC,nobold]"
separator1="#[bg=$BG,fg=$GR0,nobold]"

# Left status bar
# -------------------------------------------------------------
left_segment0="  #S "
left_segment1="  #{pane_current_path} "

tmux set -g status-left "\
${level0}${left_segment0}${separator0}\
${level1}${left_segment1}${separator1}"

# Right status bar
# -------------------------------------------------------------
# right_segment="  "
right_segment=" #{session_attached} "

# Prefix highlight
tmux set -g @prefix_highlight_show_copy_mode    'on'
tmux set -g @prefix_highlight_empty_has_affixes 'off'
tmux set -g @prefix_highlight_empty_prompt      ""
tmux set -g @prefix_highlight_prefix_prompt     " Prefix "
tmux set -g @prefix_highlight_copy_prompt       ' Copy   '
tmux set -g @prefix_highlight_output_prefix     "#[fg=$TC]#[bg=$GR0]#[bg=$TC]#[fg=$BG]"
tmux set -g @prefix_highlight_output_suffix     "#[fg=$TC]#[bg=$BG]"

tmux set -g status-right "\
${separator1}${level1}${right_segment}\
#{prefix_highlight}"

# Windows list
# -------------------------------------------------------------
tmux set -g status-style bg="$BG",fg="$TC"

tmux set -g window-status-separator      ""
tmux set -g status-justify               left
tmux set -g window-status-format         " #I:#W#F "
tmux set -g window-status-current-format "#[fg=$BG,bg=$GR1]#[fg=$TC,bold] #I:#W#F #[fg=$GR1,bg=$BG,nobold]"
tmux set -g window-status-activity-style "fg=colour13"
tmux set -g window-status-bell-style     "fg=colour9"

# Pane
# -------------------------------------------------------------
# Pane border
tmux set -g pane-border-style        "bg=default,fg=$GR2"
tmux set -g pane-active-border-style "bg=default,fg=$TC"

# Pane number indicator
tmux set -g display-panes-colour        "$GR2"
tmux set -g display-panes-active-colour "$TC"

# Misc
# -------------------------------------------------------------
# Clock
tmux set -g clock-mode-colour "$TC"
tmux set -g clock-mode-style  24

# Message
tmux set -g message-style "fg=$TC,bg=$BG"

# Command prompt
tmux set -g message-command-style "fg=$TC,bg=$BG"

# Copy mode
tmux set -g mode-style "fg=$BG,bg=$TC"
