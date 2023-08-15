#!/bin/bash

if grep -q no_clock ~/.config/i3/i3status.conf;
then
  cp ~/.config/i3/i3status_clock.conf ~/.config/i3/i3status.conf;
elif grep -q clock ~/.config/i3/i3status.conf;
then
  cp ~/.config/i3/i3status_no_clock.conf ~/.config/i3/i3status.conf;
fi

