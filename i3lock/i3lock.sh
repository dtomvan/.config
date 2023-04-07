#!/bin/env bash

mantablockscreen && exit

B='#00000000' # blank
C='#ffffff22' # clear ish
D='#81a1c1cc' # default
T='#88c0d0ee' # text
W='#bf616aee' # wrong
V='#5e81acbb' # verifying
L='#4c566aaa' # inside

i3lock \
    -n \
    --redraw-thread \
    --color="#00000000" \
    --insidever-color=$C \
    --ringver-color=$V \
    \
    --insidewrong-color=$C \
    --ringwrong-color=$W \
    \
    --inside-color=$L \
    --ring-color=$D \
    --line-color=$B \
    --separator-color=$D \
    \
    --verif-color=$T \
    --wrong-color=$T \
    --time-color=$T \
    --date-color=$T \
    --layout-color=$T \
    --keyhl-color=$W \
    --bshl-color=$W \
    \
    --screen 1 \
    --clock \
    --indicator \
    --time-str="%I:%M:%S %p" \
    --date-str="%A, %d-%m-%Y" \
    --keylayout 1 \
    --radius 120 \
    --ring-width 12 \
    --blur 8 \
    --greeter-text="Hello, $(whoami). Type in your password to begin." \
    --greeter-size=20 \
    --greeter-color=$T \
    --greeter-pos x+w/2:y+h/2+150 \
    \
    --pass-screen-keys \
    --pass-volume-keys \
    --pass-media-keys
