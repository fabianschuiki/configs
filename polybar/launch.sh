#!/usr/bin/env bash
killall -q polybar
polybar-msg cmd quit
echo "---" | tee -a /tmp/polybar.log
for MONITOR in $(xrandr | grep " connected" | cut -f1 -d" "); do
    export MONITOR
    # polybar top -r >>/tmp/polybar.log 2>&1 & disown
    polybar bottom -r >>/tmp/polybar.log 2>&1 & disown
done
