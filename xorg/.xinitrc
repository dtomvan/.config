#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

export AWT_TOOLKIT=MToolkit
export MOZ_ENABLE_WAYLAND=0
export GDK_BACKEND=x11
xsetroot -cursor_name left_ptr
picom --dbus &
~/i3lock.sh && xautolock -notify 10 -notifier 'notify-send "locking in 10 seconds..."' -locker "systemctl suspend" -nowlocker ./i3lock.sh &
playerctld daemon &
# echo "RUNNING VOLCTL" && sleep 1 && volctl &
clipmenud &
setxkbmap -option grp:alt_caps_toggle -option compose:rwin &
sleep 10 && check-updates &
hsetroot -solid "#181825" &
source ~/.profile
lxsession &
eww daemon &
sleep 10 && ~/bg.sh bg.gif &
deadd-notification-center &
sleep 10 && discord \
    --ignore-gpu-blocklist \
    --disable-features=UseOzonePlatform \
    --enable-features=VaapiVideoDecoder \
    --use-gl=desktop \
    --enable-gpu-rasterization \
    --enable-zero-copy \
    --enable-features=VaapiIgnoreDriverChecks \
    --disable-features=UseChromeOSDirectVideoDecoder \
    --start-minimized &
XINIT=1 bash ~/.profile || true &
~/obs-sinks.sh &
sh -c 'pactl unload-module module-switch-on-connect; pactl load-module module-switch-on-connect;' &
birdtray &
mpd-rpc &
aplay ~/startup.wav &
exec dbus-launch $HOME/.local/bin/bspwm-start
