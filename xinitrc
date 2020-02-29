# Reload Xresources on start
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set keyboard layout and delay/rate
source ~/.config/i3/keyboardswap.sh us

# Set mouse acceleration
xset mouse 3 6 &

# Set Video Output
xrandr --setprovideroutputsource modesetting NVIDIA-0
source ~/.config/i3/video.sh -d

exec i3
