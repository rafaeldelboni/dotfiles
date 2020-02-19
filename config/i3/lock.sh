#!/usr/bin/env bash

scrot -o /tmp/screenshot.png
convert -scale 10% -blur 0x0.5 -resize 1000% /tmp/screenshot.png /tmp/screenshot.png
i3lock -i /tmp/screenshot.png
