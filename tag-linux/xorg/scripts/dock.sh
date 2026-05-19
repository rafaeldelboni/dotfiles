#!/usr/bin/env bash
# Requires: xrandr, md5sum, awk

# Only the first 128 bytes (256 hex chars) of EDID are hashed —
# this strips GPU-specific extension blocks for stable matching.
INTERNAL_HASH="8181c458d4b3fc93292725b6ee6b15c4"
DOCK_HASH="de521635c38ccd5870a769ec8b190bf9"

EDID_BASE_LEN=256

# Parse xrandr --props and output one line per connected display:
#   OUTPUT_NAME|hex_edid
# The EDID hex is the concatenation of all hex lines under each EDID: block.
parse_edids() {
    xrandr --props | awk '
        / connected/ {
            if (output != "") printf "%s|%s\n", output, edid
            output = $1
            edid = ""
            in_edid = 0
        }

        /^\tEDID:/ {
            in_edid = 1
            next
        }

        /^\t\t[0-9a-f]/ && in_edid {
            line = $0
            gsub(/[[:space:]]/, "", line)
            edid = edid line
        }

        /^[^\t]/ && !/^Screen/ {
            in_edid = 0
        }

        END {
            if (output != "") printf "%s|%s\n", output, edid
        }
    '
}

# Hash an EDID hex string by truncating to the first EDID_BASE_LEN chars
# (base 128-byte EDID block) and computing its md5sum.
hash_edid() {
    printf '%s' "$1" | cut -c1-"$EDID_BASE_LEN" | md5sum | awk '{print $1}'
}

# Find the xrandr output name whose truncated EDID hash matches the target.
# Prints the output name and returns 0 on match, prints nothing and returns 1
# if no connected display matches.
find_by_edid_hash() {
    local target="$1"
    local output edid
    while IFS='|' read -r output edid; do
        if [ "$(hash_edid "$edid")" = "$target" ]; then
            echo "$output"
            return 0
        fi
    done < <(parse_edids)
}

# List xrandr output names of all currently connected displays.
connected_outputs() {
    xrandr --query | grep ' connected' | awk '{print $1}'
}

internal=$(find_by_edid_hash "$INTERNAL_HASH")
dock=$(find_by_edid_hash "$DOCK_HASH")

if [ -n "$dock" ] && [ -n "$internal" ]; then
    xrandr \
        --output "$dock" --auto --primary --left-of "$internal" \
        --output "$internal" --auto --dpi 144
elif [ -n "$internal" ]; then
    off_cmd=""
    while IFS= read -r name; do
        [ "$name" != "$internal" ] && off_cmd="$off_cmd --output $name --off"
    done < <(connected_outputs)
    xrandr \
        --output "$internal" --auto --primary --dpi 144 --pos 0x0 \
        $off_cmd
fi

i3-msg restart > /dev/null 2>&1