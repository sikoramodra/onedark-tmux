#!/usr/bin/env bash

get_tmux_option() {
  local option value default
  option="$1"
  default="$2"
  value="$(tmux show-option -gqv "$option")"

  if [ -n "$value" ]; then
    echo "$value"
  else
    echo "$default"
  fi
}

set() {
  local option=$1
  local value=$2
  tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
  local option=$1
  local value=$2
  tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

main() {
  # Aggregate all commands in one array
  local tmux_commands=()

  # colors
  thm_bg="#282c34"
  thm_fg="#abb2bf"
  thm_black2="#2D3139"
  thm_black3="#3b3f4c"
  thm_gray="#5c6370"
  thm_blue="#61afef"
  thm_red="#e06c75"

  # status
  set status "on"
  set status-interval 1
  set status-bg "${thm_bg}"
  set status-justify "left"
  set status-position "top"

  # messages
  set message-style "fg=${thm_blue} bg=${thm_gray}"
  set message-command-style "fg=${thm_blue} bg=${thm_gray}"

  # panes
  # set pane-border-style "fg=${thm_gray}"
  # set pane-active-border-style "fg=${thm_gray}"

  # windows
  # setw window-status-separator ""

  # --------=== Statusline
  # set status-left ""
  set status-right "#{?client_prefix,#[fg=$thm_red bold],#[fg=$thm_blue bold]}#S "

  setw window-status-format "#[fg=$thm_fg bg=$thm_black2] #I #W "
  setw window-status-current-format "#[fg=$thm_bg bold bg=$thm_blue] #I #W "

  # --------=== Modes
  setw clock-mode-colour "${thm_blue}"
  setw mode-style "fg=${thm_blue} bg=${thm_black3} bold"

  tmux "${tmux_commands[@]}"
}

main "$@"
