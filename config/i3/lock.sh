#!/usr/bin/env bash

B='#00000000' # blank
C='#ffffff22' # clear ish
D='#3ea290'   # default
T='#ffffff'   # text
W='#ffffff'   # wrong
V='#191919'   # verifying

i3lock -i $HOME/.config/i3/josh-rose-trYl7JYATH0-unsplash.png \
--insidever-color=$C   \
--ringver-color=$V     \
\
--insidewrong-color=$C \
--ringwrong-color=$W   \
\
--inside-color=$B      \
--ring-color=$D        \
--line-color=$B        \
--separator-color=$D   \
\
--verif-color=$T        \
--wrong-color=$T        \
--time-color=$T        \
--date-color=$T        \
--layout-color=$T      \
--keyhl-color=$W       \
--bshl-color=$W        \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--time-str="%H:%M:%S"  \
--date-str="%A, %m %Y" \
--keylayout 1         \

# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --textsize=20
# --modsize=10
# --timefont="JetBrainsMono Nerd Font Mono"
# --datefont=monofur
