#!/usr/bin/env bash
hyprctl dispatch "hl.dsp.workspace.move({ workspace = $(hyprctl activeworkspace -j | jq -r '.id'), monitor = 0 })"
