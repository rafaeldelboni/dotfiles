#!/usr/bin/env bash
argument=$1
us_layout_cmd="setxkbmap -layout us -variant intl -option"
us_swap_layout_cmd="setxkbmap -layout us -variant intl -option caps:swapescape"
br_swap_layout_cmd="setxkbmap -layout br -variant abnt2 -option caps:swapescape"

current_layouts=$(setxkbmap -query | awk '
  BEGIN{layout="";variant=""}
    /^layout/{layout=$2}
    /swapescape$/{swap="_swap"}
  END{printf("%s%s",layout,swap)}')

#if no argument is supplied switch between layouts (Us, Us Swap and Gb Swap in this case)
if [ -z $argument ]; then
  case $current_layouts in
    us)
      argument='us_swap'
      ;;
    us_swap)
      argument='br_swap'
      ;;
    br_swap)
      argument='us'
      ;;
  esac
fi

echo ${current_layouts}"->"${argument}

eval "$"$argument"_layout_cmd"

xset r rate 150 70
