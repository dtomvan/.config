#!/bin/sh

xdotool getwindowname $(xdotool getwindowfocus) | grep Discord
isdiscord=$?

if [ $isdiscord -eq 0 ]; then
    eval "$(xdotool getmouselocation --shell)"
    xdotool mousemove 0 0
fi

if [ "$1" = "move" ]; then
	bspc node -d "$2"
elif [ "$1" = "follow" ]; then
	bspc node -d "$2" -f
elif [ "$1" = "last" ]; then
    bspc desktop -f last
else
	bspc desktop -f "$2"
fi

if [ $isdiscord -eq 0 ]; then
    xdotool mousemove --screen $SCREEN $X $Y
fi
