#!/bin/bash

while sleep 1; do
    visible="$(hyprctl clients -j |
        jq ". | map(select(.workspace.name == $(hyprctl activeworkspace -j | jq .name)) | select(.floating == false)) | length")"

    if [ 0 -lt "$visible" ]; then
        hyprctl dispatch layerrule blur,swww
    else
        hyprctl dispatch layerrule unset,swww
    fi
done
