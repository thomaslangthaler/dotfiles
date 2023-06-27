#!/bin/bash

# shell scipt to prepend i3status with more stuff

i3status --config ~/.config/i3/i3status.conf | while :
do
        read line
        LG=$(setxkbmap -query | awk '/layout/{print $2}') 
	VOL=$(pactl get-sink-volume 0 | grep -oe '...%' | head -1)
        echo "$LG | $VOL | $line" || exit 1
done
