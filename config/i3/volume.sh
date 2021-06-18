#!/usr/bin/env bash

# gets only the active sound source
SINK=$(pactl list short sinks | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1)
# if there isn't any active sound source get the first one
[ -z "$SINK" ] && SINK=$(pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1)

while getopts u:d:m option
do
  case "${option}"
    in
    u) $(pactl set-sink-volume $SINK +${OPTARG}%);;
    d) $(pactl set-sink-volume $SINK -${OPTARG}%);;
    m) $(pactl set-sink-mute $SINK toggle);;
  esac
done
