/usr/bin/i3-msg -t subscribe -m '["shutdown"]' | while read -r event; do
  echo "i3 logoff: $event" >> /tmp/logoff.log
done &
