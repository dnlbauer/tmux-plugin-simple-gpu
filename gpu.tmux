#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

gpu_interpolation=(
    "\#{gpu}" 
    "\#{vram}"
)

gpu_usage=(
    "#($CURRENT_DIR/scripts/gpu.sh)"
    "#($CURRENT_DIR/scripts/vram.sh)"
)

set_tmux_option() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
}

do_interpolation() {
  local all_interpolated="$1"
  for ((i = 0; i < ${#gpu_usage[@]}; i++)); do
    all_interpolated=${all_interpolated//${gpu_interpolation[$i]}/${gpu_usage[$i]}}
  done
  echo "$all_interpolated"
}

update_tmux_option() {
  local option
  local option_value
  local new_option_value
  option=$1
  option_value=$(get_tmux_option "$option")
  new_option_value=$(do_interpolation "$option_value")
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}

main
