# Reload Xresources on start
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set mouse acceleration
xset mouse 3 6 &

# Set Video Output
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exec i3
