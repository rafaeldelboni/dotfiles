# Reload Xresources on start
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set keyboard delay and rate
xset r rate 200 30

# Add UK Extended and US International as Keyboard layout Option
setxkbmap -layout gb,us -variant extd,intl -option 'grp:alt_space_toggle'
setxkbmap -option caps:swapescape

# Set Video Output
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exec i3
