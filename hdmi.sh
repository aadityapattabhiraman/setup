#!/bin/bash

# Check if HDMI-1-0 display exists
if xrandr | grep -q "HDMI-1-0 connected"; then
    # Get the highest resolution available for HDMI-1-0
    highest_res=$(xrandr --query | grep HDMI-1-0 -A 10 | grep -o "[0-9]\+x[0-9]\+" | sort -r -n -t x -k 1,1 -k 2,2 | head -n 1)
  
    # Set the highest resolution for HDMI-1-0
    xrandr --output HDMI-1-0 --mode $highest_res --left-of eDP-1
    # sleep 3
    awesome-client "awesome.restart()"
    variety -n
else
    echo "HDMI-1-0 display not found"
fi
