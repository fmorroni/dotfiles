#!/bin/sh

theme='launcher'
theme_path="$HOME/.config/rofi/themes/$theme.rasi"

rofi \
  -modi "clipboard:greenclip print" \
  -show clipboard \
  -run-command '{cmd}' \
  -theme $theme_path
