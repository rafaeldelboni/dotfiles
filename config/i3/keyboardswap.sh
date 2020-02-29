#!/usr/bin/env bash

uk_layout_cmd="setxkbmap -layout gb -variant extd -option caps:swapescape"
us_layout_cmd="setxkbmap -layout us -variant intl -option caps:swapescape"

#switch between two layouts (Us and Uk in this case)
current_layouts=$(setxkbmap -query | grep layout)

#no argument swap between us - uk
if [ -z $1 ]; then
  if [ "${current_layouts: -2}" = "us" ]; then
    eval $uk_layout_cmd
  else
    eval $us_layout_cmd
  fi
#us argument
elif [ $1 == 'us' ]; then
  eval $us_layout_cmd
#uk argument
elif [ $1 == 'uk' ]; then
  eval $uk_layout_cmd
fi

xset r rate 150 55
