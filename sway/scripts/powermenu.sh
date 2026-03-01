#!/usr/bin/env bash
# =====================================================
# POWER MENU
# ~/.config/sway/scripts/powermenu.sh
#
# Rofi-based power menu, themed from active rofi theme.
# Options: Lock, Logout, Reboot, Poweroff
# =====================================================

ACTIVE_THEME="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/active.rasi"

# ── Options ───────────────────────────────────────────
LOCK="  Lock"
LOGOUT="󰍃  Logout"
REBOOT="  Reboot"
POWEROFF="  Poweroff"
CANCEL="  Cancel"

# ── Rofi theme arg ────────────────────────────────────
ROFI_ARGS=(-dmenu -p "  System" -i -lines 5 -width 25)
if [[ -f "$ACTIVE_THEME" ]]; then
    ROFI_ARGS+=(-theme "$ACTIVE_THEME")
fi

# ── Show menu ─────────────────────────────────────────
CHOSEN="$(printf '%s\n' \
    "$LOCK" \
    "$LOGOUT" \
    "$REBOOT" \
    "$POWEROFF" \
    "$CANCEL" \
    | rofi "${ROFI_ARGS[@]}")"

# ── Act ───────────────────────────────────────────────
case "$CHOSEN" in
    "$LOCK")     swaylock --daemonize ;;
    "$LOGOUT")   swaymsg exit ;;
    "$REBOOT")   systemctl reboot ;;
    "$POWEROFF") systemctl poweroff ;;
    *)           exit 0 ;;  # Cancel or dismissed
esac
