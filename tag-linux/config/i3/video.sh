#!/usr/bin/env bash

[[ -z "${LOCAL_DPI}" ]] && DPI="96" || DPI="${LOCAL_DPI}"
[[ -z "${LOCAL_MODE}" ]] && MODE="2560x1440" || MODE="${LOCAL_MODE}"


if [[ -z "${LOCAL_INTERN}" ]]
then
  INTERN=$(xrandr | grep " connected" | grep "primary" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | tail -n 1)
else
  INTERN="${LOCAL_INTERN}"
fi

if [[ -z "${LOCAL_EXTERN}" ]]
then
  EXTERN=$(xrandr | grep " connected" | grep -v "primary" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | tail -n 1)
else
  EXTERN="${LOCAL_EXTERN}"
fi

if [[ -z "${INTERN}" || $INTERN == $EXTERN ]]
then
  DEFAULT_MODE="xrandr --output $EXTERN --auto --dpi $DPI --mode $MODE"
else
  DEFAULT_MODE="xrandr --output $EXTERN --auto --dpi $DPI --mode $MODE --left-of $INTERN"
fi

while getopts ":d :m :n :h :j :k :l" option
do
  case "${option}"
    in
    d) $([ -z "$EXTERN" ] && xrandr --auto || eval $DEFAULT_MODE);;
    m) $(xrandr --output $EXTERN --auto --same-as $INTERN);;
    n) $(xrandr --output $EXTERN --off --auto);;
    h) $(xrandr --output $EXTERN --auto --dpi $DPI --mode $MODE --left-of  $INTERN);;
    j) $(xrandr --output $EXTERN --auto --dpi $DPI --mode $MODE --below    $INTERN);;
    k) $(xrandr --output $EXTERN --auto --dpi $DPI --mode $MODE --above    $INTERN);;
    l) $(xrandr --output $EXTERN --auto --dpi $DPI --mode $MODE --right-of $INTERN);;
  esac
done
