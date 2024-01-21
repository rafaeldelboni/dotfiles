#!/usr/bin/env bash

FONT="JetBrainsMono Nerd Font Mono"

B='#00000000' # blank
C='#ffffff22' # clear ish
D='#2f71bb'   # default
T='#ffffff'   # text
W='#ffffff'   # wrong
V='#191919'   # verifying

i3lock \
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
--time-font=$FONT \
--date-font=$FONT \
--layout-font=$FONT \
--verif-font=$FONT \
--wrong-font=$FONT \
--greeter-font=$FONT \
--radius=120 \
--ring-width=10 \
--time-size=40 \
--date-size=20 \
--layout-size=15 \

# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --modsize=10
