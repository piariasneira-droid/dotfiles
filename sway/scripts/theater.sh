#!/bin/bash

# Define output names (Check 'swaymsg -t get_outputs' to verify)
INTERNAL="eDP-1"
EXTERNAL=$(swaymsg -t get_outputs | jq -r '.[] | select(.name != "eDP-1") | .name' | head -n 1)

# Check physical lid state via ACPI
LID_STATE=$(grep -oP "closed|open" /proc/acpi/button/lid/*/state)

# 1. Safety: If no external monitor is detected, always keep internal screen ON
if [ -z "$EXTERNAL" ]; then
    swaymsg output "$INTERNAL" enable
    exit 0
fi

# 2. Logic for Clamshell Mode (Lid Closed)
if [[ "$LID_STATE" == "closed" ]]; then
    swaymsg output "$INTERNAL" disable
    swaymsg output "$EXTERNAL" enable
    notify-send "Sway" "Lid Closed: TV Mode Active"
    exit 0
fi

# 3. Manual Toggle Logic (For when the lid is OPEN)
# Check if the internal screen is currently active
STATUS=$(swaymsg -t get_outputs | jq -r ".[] | select(.name == \"$INTERNAL\") | .active")

if [ "$STATUS" == "true" ]; then
    # Switch to TV only (Internal OFF)
    swaymsg output "$INTERNAL" disable
    swaymsg output "$EXTERNAL" enable
    notify-send "Sway" "Internal Screen: OFF | TV: ON"
else
    # Switch to Dual Mode or Laptop Only (Internal ON)
    swaymsg output "$INTERNAL" enable
    notify-send "Sway" "Internal Screen: ON"
fi