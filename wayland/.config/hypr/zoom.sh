#!/bin/bash

if [[ "$1" = "=" ]]; then
    hyprctl keyword misc:cursor_zoom_factor 1.0
    exit
fi
hyprctl keyword misc:cursor_zoom_factor $(printf "%s$1\n" $(hyprctl getoption -j misc:cursor_zoom_factor | jq --raw-output '.float') | bc)
