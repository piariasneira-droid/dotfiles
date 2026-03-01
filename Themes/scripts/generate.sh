#!/usr/bin/env bash
# =====================================================
# EVERGREEN FOREST — Theme Generator
# ~/.config/theme/generate.sh
#
# Usage:
#   bash ~/.config/theme/generate.sh
#   bash ~/.config/theme/generate.sh --dry-run
#   bash ~/.config/theme/generate.sh --theme ~/.config/theme/evergreen.conf
# =====================================================

set -euo pipefail

# ── Defaults ──────────────────────────────────────────
THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_FILE="$THEME_DIR/evergreen.conf"
OUTPUT_DIR="$THEME_DIR/generated"
DRY_RUN=false

# ── Parse args ────────────────────────────────────────
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)  DRY_RUN=true; shift ;;
        --theme)    THEME_FILE="$2"; shift 2 ;;
        *) echo "Unknown argument: $1"; exit 1 ;;
    esac
done

# ── Load colors ───────────────────────────────────────
# shellcheck source=/dev/null
source "$THEME_FILE"

# ── Helper: write a file (or print if dry-run) ────────
write_file() {
    local rel_path="$1"
    local content="$2"
    local target="$OUTPUT_DIR/$rel_path"

    if $DRY_RUN; then
        echo ""
        echo "============================================================"
        echo "  [DRY RUN] Would write: $target"
        echo "============================================================"
        echo "$content"
        return
    fi

    mkdir -p "$(dirname "$target")"
    printf '%s\n' "$content" > "$target"
    echo "  ✓ $rel_path"
}

echo ""
echo "🌲 Generating theme: $THEME_NAME v$THEME_VERSION"
echo "   Source : $THEME_FILE"
echo "   Output : $OUTPUT_DIR"
echo ""

# ══════════════════════════════════════════════════════
# 1. WAYBAR — colors.css
# ══════════════════════════════════════════════════════
write_file "waybar/colors.css" \
"/* =====================================================
 * $THEME_NAME — Waybar Colors
 * AUTO-GENERATED — do not edit manually.
 * Edit evergreen.conf and re-run generate.sh
 * ===================================================== */

@define-color background           rgba($BG0_A90);
@define-color transparent          rgba(0, 0, 0, 0);
@define-color tooltip_background   rgba($BG0_A95);

@define-color on_surface           #$FG0;
@define-color on_surface_muted     #$FG1;

@define-color primary              #$GREEN0;
@define-color primary_container    rgba($GREEN0_A15);
@define-color secondary            #$TEAL;
@define-color tertiary             #$ORANGE;
@define-color error                #$RED;

@define-color surface              #$BG2;
@define-color surface_variant      #$BG3;"

# ══════════════════════════════════════════════════════
# 2. ROFI — colors.rasi
# ══════════════════════════════════════════════════════
write_file "rofi/colors.rasi" \
"/* =====================================================
 * $THEME_NAME — Rofi Colors
 * AUTO-GENERATED — do not edit manually.
 * Edit evergreen.conf and re-run generate.sh
 * ===================================================== */

* {
    bg0:             #$BG0;
    bg1:             #$BG1;
    bg2:             #$BG2;
    bg3:             #$BG3;

    fg0:             #$FG0;
    fg1:             #$FG1;

    green0:          #$GREEN0;
    green1:          #$GREEN1;
    green2:          #$GREEN2;
    teal:            #$TEAL;
    orange:          #$ORANGE;
    red:             #$RED;
    yellow:          #$YELLOW;

    bg0_a90:         rgba($BG0_A90);
    bg2_a80:         rgba($BG2_A80);
    green0_a15:      rgba($GREEN0_A15);
    green0_a18:      rgba($GREEN0_A18);
    green1_a30:      rgba($GREEN1_A30);
}"

# ══════════════════════════════════════════════════════
# 3. SWAY — colors.conf
# ══════════════════════════════════════════════════════
write_file "sway/colors.conf" \
"### =====================================================
### $THEME_NAME — Sway Border Colors
### AUTO-GENERATED — do not edit manually.
### Edit evergreen.conf and re-run generate.sh
### =====================================================

### Sway client colors
### Class                 Border     Background  Text      Indicator  Child_Border
client.focused            #$GREEN0   #$BG2       #$FG0     #$TEAL     #$GREEN0
client.focused_inactive   #$BG3      #$BG2       #$FG1     #$BG3      #$BG3
client.unfocused          #$BG0      #$BG0       #$FG1     #$BG0      #$BG0
client.urgent             #$RED      #$RED       #$FG0     #$RED      #$RED
client.placeholder        #$BG0      #$BG0       #$FG1     #$BG0      #$BG0"

# ══════════════════════════════════════════════════════
# 4. SWAYNC — colors.css
# ══════════════════════════════════════════════════════
write_file "swaync/colors.css" \
"/* =====================================================
 * $THEME_NAME — SwayNC Colors
 * AUTO-GENERATED — do not edit manually.
 * Edit evergreen.conf and re-run generate.sh
 * ===================================================== */

* {
    --bg0:      #$BG0;
    --bg1:      #$BG1;
    --bg2:      #$BG2;
    --bg3:      #$BG3;

    --fg0:      #$FG0;
    --fg1:      #$FG1;

    --green0:   #$GREEN0;
    --green1:   #$GREEN1;
    --green2:   #$GREEN2;
    --teal:     #$TEAL;
    --orange:   #$ORANGE;
    --red:      #$RED;
    --yellow:   #$YELLOW;
}"

# ══════════════════════════════════════════════════════
# 5. STARSHIP — colors.toml
# ══════════════════════════════════════════════════════
write_file "starship/colors.toml" \
"# =====================================================
# $THEME_NAME — Starship Color Palette
# AUTO-GENERATED — do not edit manually.
# Edit evergreen.conf and re-run generate.sh
#
# Usage in starship.toml:
#   \$env.STARSHIP_PALETTE_PATH = \"~/.config/theme/generated/starship/colors.toml\"
#
# Or just reference the hex values directly in your
# starship.toml — this file documents the palette.
# =====================================================

# bg0     = \"#$BG0\"   # forest floor
# bg1     = \"#$BG1\"   # understory
# bg2     = \"#$BG2\"   # mid surface
# bg3     = \"#$BG3\"   # surface variant
# fg0     = \"#$FG0\"   # warm sand
# fg1     = \"#$FG1\"   # stone
# green0  = \"#$GREEN0\" # canopy leaf  — directory, character
# green1  = \"#$GREEN1\" # deep foliage
# green2  = \"#$GREEN2\" # moss
# teal    = \"#$TEAL\"   # morning dew  — git, languages
# orange  = \"#$ORANGE\" # autumn leaf  — warnings, duration
# red     = \"#$RED\"    # forest berry — errors
# yellow  = \"#$YELLOW\" # dry grass

[palettes.evergreen]
bg0     = \"#$BG0\"
bg1     = \"#$BG1\"
bg2     = \"#$BG2\"
bg3     = \"#$BG3\"
fg0     = \"#$FG0\"
fg1     = \"#$FG1\"
green0  = \"#$GREEN0\"
green1  = \"#$GREEN1\"
green2  = \"#$GREEN2\"
teal    = \"#$TEAL\"
orange  = \"#$ORANGE\"
red     = \"#$RED\"
yellow  = \"#$YELLOW\""

# ══════════════════════════════════════════════════════
# 6. GTK — colors.css
# ══════════════════════════════════════════════════════
write_file "gtk/colors.css" \
"/* =====================================================
 * $THEME_NAME — GTK 3 Colors
 * AUTO-GENERATED — do not edit manually.
 * Edit evergreen.conf and re-run generate.sh
 *
 * Add to ~/.config/gtk-3.0/gtk.css:
 *   @import url(\"/path/to/generated/gtk/colors.css\");
 * ===================================================== */

@define-color window_bg_color      #$BG0;
@define-color window_fg_color      #$FG0;

@define-color view_bg_color        #$BG1;
@define-color view_fg_color        #$FG0;

@define-color headerbar_bg_color   #$BG2;
@define-color headerbar_fg_color   #$FG0;
@define-color headerbar_border_color #$BG3;

@define-color popover_bg_color     #$BG2;
@define-color popover_fg_color     #$FG0;

@define-color dialog_bg_color      #$BG1;
@define-color dialog_fg_color      #$FG0;

@define-color sidebar_bg_color     #$BG1;
@define-color sidebar_fg_color     #$FG0;

@define-color accent_bg_color      #$GREEN0;
@define-color accent_fg_color      #$BG0;
@define-color accent_color         #$GREEN0;

@define-color success_color        #$GREEN0;
@define-color warning_color        #$ORANGE;
@define-color error_color          #$RED;

@define-color borders              #$BG3;

/* Scrollbars */
scrollbar slider {
    background-color: #$BG3;
    border-radius: 6px;
    min-width: 6px;
    min-height: 6px;
}
scrollbar slider:hover  { background-color: #$GREEN2; }
scrollbar slider:active { background-color: #$GREEN0; }

/* Selections */
selection {
    background-color: rgba($GREEN0_A18);
    color: #$FG0;
}

/* Links */
link { color: #$TEAL; }
link:hover { color: #$GREEN0; }"

# ══════════════════════════════════════════════════════
# Done
# ══════════════════════════════════════════════════════
if ! $DRY_RUN; then
    echo ""
    echo "✅ All files generated in $OUTPUT_DIR"
    echo ""
    echo "Next steps:"
    echo "  Waybar  → @import \"$OUTPUT_DIR/waybar/colors.css\";"
    echo "  Rofi    → @import \"$OUTPUT_DIR/rofi/colors.rasi\""
    echo "  Sway    → include $OUTPUT_DIR/sway/colors.conf"
    echo "  SwayNC  → @import url(\"$OUTPUT_DIR/swaync/colors.css\");"
    echo "  GTK     → @import url(\"$OUTPUT_DIR/gtk/colors.css\");"
    echo "  Starship→ palette = \"evergreen\" + import colors.toml"
    echo ""
fi
