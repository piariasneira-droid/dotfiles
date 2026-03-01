#!/usr/bin/env bash
# =====================================================
# THEME SWITCHER
# ~/Themes/switch-theme.sh
#
# Usage:
#   bash switch-theme.sh                  # opens rofi picker
#   bash switch-theme.sh evergreen        # switch directly by slug
# =====================================================

set -euo pipefail

THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GENERATE="$THEME_DIR/generate.sh"

# ── Collect available themes ──────────────────────────
mapfile -t CONF_FILES < <(find "$THEME_DIR" -maxdepth 1 -name "*.conf" | sort)

if [[ ${#CONF_FILES[@]} -eq 0 ]]; then
    echo "✗ No .conf files found in $THEME_DIR"
    exit 1
fi

# ── Read current active slug ───────────────────────────
ACTIVE_LINK="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/active.rasi"
CURRENT_SLUG=""
if [[ -L "$ACTIVE_LINK" ]]; then
    link_target="$(readlink "$ACTIVE_LINK")"
    CURRENT_SLUG="$(basename "$(dirname "$(dirname "$link_target")")")"
fi

# ── Build maps: slug→name and name→slug ───────────────
declare -A SLUG_TO_NAME
declare -A NAME_TO_SLUG
MENU_ENTRIES=()

for f in "${CONF_FILES[@]}"; do
    slug="$(basename "$f" .conf)"
    name="$(bash -c "source '$f'; echo \"\$THEME_NAME\"")"
    SLUG_TO_NAME["$slug"]="$name"
    NAME_TO_SLUG["$name"]="$slug"

    # Mark active theme with a bullet
    if [[ "$slug" == "$CURRENT_SLUG" ]]; then
        MENU_ENTRIES+=("  $name")
    else
        MENU_ENTRIES+=("    $name")
    fi
done

# ── Resolve target theme ──────────────────────────────
if [[ $# -ge 1 ]]; then
    TARGET_SLUG="$1"
    if [[ -z "${SLUG_TO_NAME[$TARGET_SLUG]+_}" ]]; then
        echo "✗ Unknown theme: $TARGET_SLUG"
        echo "  Available:"
        for slug in "${!SLUG_TO_NAME[@]}"; do
            echo "    $slug  —  ${SLUG_TO_NAME[$slug]}"
        done
        exit 1
    fi
else
    if ! command -v rofi &>/dev/null; then
        echo "✗ rofi not found and no theme argument given"
        echo "  Usage: switch-theme.sh <theme-slug>"
        exit 1
    fi

    ROFI_THEME_ARG=()
    if [[ -L "$ACTIVE_LINK" && -f "$ACTIVE_LINK" ]]; then
        ROFI_THEME_ARG=(-theme "$ACTIVE_LINK")
    fi

    CHOSEN="$(printf '%s\n' "${MENU_ENTRIES[@]}" | \
        rofi -dmenu \
             -p "🎨 Theme" \
             "${ROFI_THEME_ARG[@]}" \
             -i \
             -no-custom)"

    [[ -z "$CHOSEN" ]] && exit 0

    # Strip all leading whitespace and the bullet icon to recover the name
    CHOSEN_NAME="${CHOSEN#"${CHOSEN%%[! ]*}"}"
    TARGET_SLUG="${NAME_TO_SLUG[$CHOSEN_NAME]}"
fi

# ── Already active? ───────────────────────────────────
if [[ "$TARGET_SLUG" == "$CURRENT_SLUG" ]]; then
    echo "✓ ${SLUG_TO_NAME[$TARGET_SLUG]} is already active — nothing to do"
    exit 0
fi

# ── Generate ──────────────────────────────────────────
echo ""
echo "🎨 Switching: ${SLUG_TO_NAME[$CURRENT_SLUG]:-none} → ${SLUG_TO_NAME[$TARGET_SLUG]}"
echo ""

bash "$GENERATE" --theme "${TARGET_SLUG}.conf"

# ── Reload sway ───────────────────────────────────────
if command -v swaymsg &>/dev/null; then
    echo "→ Reloading sway"
    swaymsg reload 2>/dev/null \
        && echo "  ✓ Sway reloaded" \
        || echo "  ⚠ Sway reload failed (not running?)"
fi

# ── Reload swaync ─────────────────────────────────────
if command -v swaync-client &>/dev/null; then
    echo "→ Reloading swaync"
    swaync-client -rs 2>/dev/null \
        && echo "  ✓ SwayNC reloaded" \
        || echo "  ⚠ SwayNC reload failed (not running?)"
fi

# ── Restart waybar ────────────────────────────────────
WAYBAR_SCRIPT="$HOME/.config/sway/scripts/execwaybar.sh"
if [[ -x "$WAYBAR_SCRIPT" ]]; then
    echo "→ Restarting waybar"
    bash "$WAYBAR_SCRIPT" && echo "  ✓ Waybar restarted"
elif command -v waybar &>/dev/null; then
    echo "→ Restarting waybar (pkill + relaunch)"
    pkill waybar 2>/dev/null || true
    sleep 0.3
    waybar &>/dev/null &
    disown
    echo "  ✓ Waybar relaunched"
fi

echo ""
echo "✅  ${SLUG_TO_NAME[$TARGET_SLUG]} is now active"
echo ""