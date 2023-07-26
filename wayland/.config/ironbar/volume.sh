#!/bin/bash

pactl get-sink-volume @DEFAULT_SINK@ \
    | grep -oP 'front-left: [0-9]+ /\K.*?%'
