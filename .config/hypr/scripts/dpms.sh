#!/usr/bin/env bash
# Usage: dpms.sh on|off
# Switches all monitors on or off (used by swayidle, see config/defaults.lua).

case "$1" in
    on|off) exec hyprctl dispatch "hl.dsp.dpms({ action = '$1' })" ;;
    *)      echo "usage: ${0##*/} on|off" >&2; exit 1 ;;
esac
