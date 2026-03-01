#!/usr/bin/env bash
# =====================================================
# SCREEN TOGGLE
# ~/.config/sway/scripts/screenoff.sh
#
# Toggles the internal laptop screen on/off.
# Audio, processes and network keep running.
# Lid can be closed without suspend.
# =====================================================

INTERNAL="eDP-1"

STATUS=$(swaymsg -t get_outputs \
    | jq -r ".[] | select(.name == \"$INTERNAL\") | .active")

if [[ "$STATUS" == "true" ]]; then
    swaymsg output "$INTERNAL" dpms off
    notify-send "Screen" "Display off — everything still running" \
        --icon=display --expire-time=2000
else
    swaymsg output "$INTERNAL" dpms on
    notify-send "Screen" "Display on" \
        --icon=display --expire-time=2000
fi