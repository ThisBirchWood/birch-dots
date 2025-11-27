#!/bin/bash

choice=$(printf "25 min work\n50 min work\nShort break (5)\nLong break (15)\nStop timer" |
    wofi --dmenu --prompt "Pomodoro")

case "$choice" in
    "25 min work") waybar-module-pomodoro work -w 25 ;;
    "50 min work") waybar-module-pomodoro work -w 50 ;;
    "Short break (5)") waybar-module-pomodoro break -s 5 ;;
    "Long break (15)") waybar-module-pomodoro break -l 15 ;;
    "Stop timer") waybar-module-pomodoro reset ;;
esac

