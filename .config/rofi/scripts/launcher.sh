#!/bin/zsh

theme='launcher'
theme_path="$HOME/.config/rofi/themes/$theme.rasi"

# echo $PATH | /bin/tr ':' '\n' | rofi -dmenu

rofi \
  -show drun \
  -theme "$theme_path"
