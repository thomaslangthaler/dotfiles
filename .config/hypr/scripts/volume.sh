#!/usr/bin/env bash
# Usage: volume.sh up|down|mute
# Adjusts the default PipeWire sink (capped at 100%) and reports to wob.

sink=@DEFAULT_AUDIO_SINK@
fifo="/tmp/${HYPRLAND_INSTANCE_SIGNATURE}.wob"

case "$1" in
    up)   wpctl set-volume -l 1.0 "$sink" 5%+ ;;
    down) wpctl set-volume "$sink" 5%- ;;
    mute) wpctl set-mute "$sink" toggle ;;
    *)    echo "usage: ${0##*/} up|down|mute" >&2; exit 1 ;;
esac

out=$(wpctl get-volume "$sink")
if [[ $out == *MUTED* ]]; then
    level=0
else
    level=$(awk '{printf "%d", $2 * 100 + 0.5}' <<<"$out")
fi

# Opening a FIFO for writing blocks while wob isn't reading, so give up after 1s.
[[ -p $fifo ]] && timeout 1 bash -c 'echo "$1" > "$2"' _ "$level" "$fifo"
exit 0
