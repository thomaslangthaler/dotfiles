#!/bin/bash

# shell scipt to prepend i3status with more stuff

i3status --config ~/.config/i3/i3status.conf | while :
do
        read line
        LG=$(setxkbmap -query | awk '/layout/{print $2}') 
        echo "$LG | $line" || exit 1
done
