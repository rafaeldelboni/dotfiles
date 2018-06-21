[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -layout gb,us -variant extd,intl -option 'grp:alt_space_toggle'
setxkbmap -option caps:swapescape

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exec i3
