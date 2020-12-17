#!/usr/bin/env bash

B='#00000000' # blank
C='#ffffff22' # clear ish
D='#3ea290'   # default
T='#ffffff'   # text
W='#ffffff'   # wrong
V='#191919'   # verifying

i3lock -i $HOME/.config/i3/josh-rose-trYl7JYATH0-unsplash.png \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
--keylayout 1         \

# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --textsize=20
# --modsize=10
# --timefont="JetBrainsMono Nerd Font Mono"
# --datefont=monofur
