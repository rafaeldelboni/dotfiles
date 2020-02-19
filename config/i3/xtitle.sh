#!/usr/bin/env bash

# Start xtitle monitor and send signal 10 to i3blocks
if xtitle -v >/dev/null 2>&1; then
  ps -ef | grep -s "xtitle -s" | grep -v grep >/dev/null || {
    xtitle -s | while read -r event;
      do pkill -SIGRTMIN+10 i3blocks
    done &
  }
fi
