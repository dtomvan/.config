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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
export AWT_TOOLKIT=MToolkit
export QT_QPA_PLATFORMTHEME=qt5ct
xsetroot -cursor_name left_ptr
xbindkeys
picom --experimental-backends --xrender-sync-fence --backend glx &
~/i3lock.sh && xautolock -notify 10 -notifier 'notify-send "locking in 10 seconds..."' -locker "systemctl suspend" -nowlocker ./i3lock.sh &
playerctld daemon &
# echo "RUNNING VOLCTL" && sleep 1 && volctl &
clipmenud &
setxkbmap -option grp:alt_caps_toggle -option compose:rwin &
sleep 10 && check-updates &
discord-notify &
source ~/.profile
lxsession &
eww daemon &
hsetroot -solid "#16161D" &
~/bg.sh bg.gif &
deadd-notification-center &
discord-canary --no-sandbox \
--start-minimized \
--ignore-gpu-blocklist \
--disable-features=UseOzonePlatform \
--enable-features=VaapiVideoDecoder \
--use-gl=desktop \
--enable-gpu-rasterization \
--enable-zero-copy &
XINIT=1 bash ~/.profile || true &
exec dbus-launch $HOME/.local/bin/bspwm-start
