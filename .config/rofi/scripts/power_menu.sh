#!/bin/bash

theme='power_menu'
theme_path="$HOME/.config/rofi/themes/$theme.rasi"
scripts="$HOME/.config/rofi/scripts"

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host='󰣇 Arch'

# Options
suspend='  Suspend'
hibernate='  Hibernate'
reboot='  Reboot'
shutdown='  Shutdown'
yes='󰡕  Yes'
no='  No'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "$host" \
		-mesg "Uptime: $uptime" \
		-theme "$theme_path"
}

# Ask for confirmation
confirm_exit() {
	echo -en "$yes\n$no" | "$scripts/confirmation.sh" "Confirm: $1"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$suspend\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	confirmation="$(confirm_exit "$(echo "$1" | cut -f 2 -d ' ')")"
	if [[ "$confirmation" == "$yes" ]]; then
		if [[ $1 == "$suspend" ]]; then
			systemctl suspend-then-hibernate
		elif [[ $1 == "$hibernate" ]]; then
			"$HOME/scripts/bin/lockscreen"
			systemctl hibernate
		elif [[ $1 == "$reboot" ]]; then
			systemctl reboot
		elif [[ $1 == "$shutdown" ]]; then
			systemctl poweroff
		fi
	else
		exit 0
	fi
}

# Actions
action="$(run_rofi)"
if [[ -n $action ]]; then
	run_cmd "$action"
fi
