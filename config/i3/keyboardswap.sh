#!/usr/bin/env bash
argument=$1
us_layout_cmd="setxkbmap -layout us -variant intl -option"
gb_swap_layout_cmd="setxkbmap -layout gb -variant extd -option caps:swapescape"
us_swap_layout_cmd="setxkbmap -layout us -variant intl -option caps:swapescape"

current_layouts=$(setxkbmap -query | awk '
  BEGIN{layout="";variant=""}
    /^layout/{layout=$2}
    /swapescape$/{swap="_swap"}
  END{printf("%s%s",layout,swap)}')

#if no argument is supplied switch between layouts (Us, Us Swap and Gb Swap in this case)
if [ -z $argument ]; then
  if [ $current_layouts == 'us' ]; then
    argument='us_swap'
  elif [ $current_layouts == 'us_swap' ]; then
    argument='gb_swap'
  elif [ $current_layouts == 'gb_swap' ]; then
    argument='us'
  fi
fi

echo ${current_layouts}"->"${argument}

eval "$"$argument"_layout_cmd"

xset r rate 150 55
