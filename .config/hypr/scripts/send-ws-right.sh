#!/usr/bin/env bash
hyprctl dispatch moveworkspacetomonitor "$(hyprctl activeworkspace -j | jq -r '.id')" 0

