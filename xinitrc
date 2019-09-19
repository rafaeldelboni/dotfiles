# Reload Xresources on start
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set keyboard layout and delay/rate
setxkbmap -layout gb -variant extd -option caps:swapescape
xset r rate 150 55

# Set mouse acceleration
xset mouse 3 6 &

# Set Video Output
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exec i3
