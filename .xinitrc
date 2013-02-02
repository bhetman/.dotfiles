#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets)
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

eval $(ssh-agent)

xset +fp /usr/share/fonts/local
xset fp rehash
xset b 5 2800
xbindkeys
xmodmap ~/.Xmodmap
/usr/bin/xscreensaver -no-splash -no-capture-stderr &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/src/tomorrow-theme/Xdefaults/XresourceTomorrowNightBright ]] &&
  xrdb -merge ~/src/tomorrow-theme/Xdefaults/XresourceTomorrowNightBright
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
DEFAULT_SESSION=i3
case $1 in
  awesome|wmii|xmonad|i3) exec $1;;
  kde) exec startkde;;
  *) exec $DEFAULT_SESSION;;
esac
