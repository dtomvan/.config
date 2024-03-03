#!/bin/bash

locker() {
    swayidle -w                                                                         \
    timeout 290 'pgrep swaylock || hyprctl notify 2 10000 0 "Locking in 10 seconds..."' \
    timeout 300 ./lock.sh                                                               \
    timeout 600 'hyprctl dispatch dpms off'                                             \
    resume 'hyprctl dispatch dpms on'                                                   \
    before-sleep ./lock.sh                                                              &
}

if [ "$1" = "RELOAD_SWAYIDLE" ]; then
    pkill swayidle
    locker &
    disown
    exit
fi

pushd ~/.config/hypr/ || exit 1

./prev.sh &

locker &

wait
popd || exit
