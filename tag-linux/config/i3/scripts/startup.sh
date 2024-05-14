#!/bin/env bash

feh --bg-fill $HOME/.config/i3/galaxy.png

# Kill already running process
_ps=(nm-applet picom xfce4-notifyd xfce-polkit)

for _prs in "${_ps[@]}"; do
  if [[ $(pidof ${_prs}) ]]; then
    killall -9 ${_prs}
  fi
done

nm-applet &

picom &

/usr/lib/xfce4/notifyd/xfce4-notifyd &

/usr/lib/xfce-polkit/xfce-polkit &
