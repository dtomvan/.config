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
wmname LG3D
xsetroot -cursor_name left_ptr
xbindkeys
xautolock -locker ./i3lock.sh -nowlocker ./i3lock.sh &
ckb-next -b &
emacs --daemon &
volctl &
keynav &
picom --backend glx --xrender-sync-fence &
clipmenud &
~/.local/bin/bspwm-start
