#!/bin/sh

theme='launcher'
theme_path="$HOME/.config/rofi/themes/$theme.rasi"

rofi \
  -show drun \
  -theme $theme_path
