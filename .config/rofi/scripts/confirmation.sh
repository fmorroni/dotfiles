#!/bin/sh

rofi -dmenu \
  -mesg "$1" \
  -markup-rows \
  -theme "confirmation_window.rasi"
