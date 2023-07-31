#!/bin/bash

source ~/.config/hypr/env.bash

currentworky=
getworkspace lastworky

listen | while read -r line; do
    if [[ "$line" =~ ^workspace\>\>(.*)$ ]]; then
        lastworky="$currentworky"
        currentworky="${BASH_REMATCH[1]}"
    elif [ 'submap>>prevworkspace' = "$line" ]; then
        hb \
            dispatch submap reset\; \
            dispatch workspace "$lastworky" > /dev/null
    elif [[ "$line" =~ ^submap\>\>movetoprevworkspace(.*)$ ]]; then
        hb \
            dispatch submap reset\; \
            dispatch "movetoworkspace${BASH_REMATCH[1]}" "$lastworky" > /dev/null
    fi
done

