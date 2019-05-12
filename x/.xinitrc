#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -I"$HOME" -merge "$userresources"
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

# Swap Caps Lock and Left Ctrl
setxkbmap -layout us -option ctrl:swapcaps
# Adjust keyboard delay
xset r rate 250 30
# Turn off beep
xset -b b off
# Add font paths
xset +fp /usr/share/fonts/adobe-source-code-pro/
xset +fp /usr/share/fonts/noto/
xset +fp /usr/share/fonts/OTF/
# Start ssh-agent
eval "$(ssh-agent)"

exec i3
