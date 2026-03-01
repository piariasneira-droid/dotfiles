#!/usr/bin/env bash
# =====================================================
# THEME GENERATOR
# ~/Themes/generate.sh
#
# Usage:
#   bash generate.sh                           # uses evergreen.conf (default)
#   bash generate.sh --theme arctic-night.conf
#   bash generate.sh --theme arctic-night.conf --dry-run
# =====================================================

set -euo pipefail

# ── Paths — all relative to this script's location ───
THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_FILE="$THEME_DIR/evergreen.conf"
SCRIPTS_DIR="$THEME_DIR/scripts"
OUTPUT_DIR="$THEME_DIR/generated"
WALLPAPERS_DIR="$THEME_DIR/wallpapers"
DRY_RUN=false

# ── Parse args ────────────────────────────────────────
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)  DRY_RUN=true;  shift ;;
        --theme)    THEME_FILE="$THEME_DIR/$2"; shift 2 ;;
        *) echo "Unknown argument: $1"; exit 1 ;;
    esac
done

# ── Resolve theme slug & output dir ───────────────────
THEME_SLUG="$(basename "$THEME_FILE" .conf)"
THEME_OUTPUT_DIR="$OUTPUT_DIR/$THEME_SLUG"

# ── Validate theme file ───────────────────────────────
if [[ ! -f "$THEME_FILE" ]]; then
    echo "✗ Theme file not found: $THEME_FILE"
    echo "  Available themes:"
    for f in "$THEME_DIR"/*.conf; do echo "    $(basename "$f")"; done
    exit 1
fi

# ── Load colors ───────────────────────────────────────
source "$THEME_FILE"

# ── Helper: write a generated file ────────────────────
write_file() {
    local rel_path="$1"
    local content="$2"
    local target="$THEME_OUTPUT_DIR/$rel_path"

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

# ── Helper: ensure a directory exists ─────────────────
ensure_dir() {
    local dir="$1"
    if $DRY_RUN; then echo "  [DRY RUN] Would ensure dir: $dir"; return; fi
    if [[ ! -d "$dir" ]]; then mkdir -p "$dir"; echo "  ✓ Created dir: $dir"; fi
}

# ── Helper: create a symlink (force) ──────────────────
make_link() {
    local link="$1"
    local target="$2"
    if $DRY_RUN; then echo "  [DRY RUN] Would symlink: $link → $target"; return; fi
    if [[ -L "$link" || -e "$link" ]]; then rm -f "$link"; fi
    ln -s "$target" "$link"
    echo "  ✓ Symlinked: $link → $target"
}

# ── Helper: deploy generated file to its config path ──
# Used by all module scripts.
# Usage: _deploy_symlink <destination> <generated-source>
_deploy_symlink() {
    local link="$1"
    local target="$2"

    if $DRY_RUN; then
        echo "  [DRY RUN] Would deploy: $link → $target"
        return
    fi

    mkdir -p "$(dirname "$link")"
    if [[ -L "$link" || -e "$link" ]]; then rm -f "$link"; fi
    ln -s "$target" "$link"
    echo "  ✓ Deployed: $link"
}

# ── Helper: auto-detect wallpaper for current theme ───
# Looks for wallpapers/<slug>.{jpg,jpeg,png,webp} and
# symlinks it to wallpapers/active.
# Falls back gracefully if no match found.
_deploy_wallpaper() {
    local found=""

    for ext in jpg jpeg png webp; do
        local candidate="$WALLPAPERS_DIR/${THEME_SLUG}.${ext}"
        if [[ -f "$candidate" ]]; then
            found="$candidate"
            break
        fi
    done

    if [[ -z "$found" ]]; then
        echo "  ⚠ No wallpaper found for '$THEME_SLUG' in $WALLPAPERS_DIR"
        echo "    Expected: ${THEME_SLUG}.jpg (or .jpeg/.png/.webp)"
        echo "    Keeping previous wallpaper active"
        return
    fi

    if $DRY_RUN; then
        echo "  [DRY RUN] Would set wallpaper: $found"
        return
    fi

    make_link "$WALLPAPERS_DIR/active" "$found"
    echo "  ✓ Wallpaper: $(basename "$found")"
}

# ── Banner ────────────────────────────────────────────
echo ""
echo "🎨 Generating theme : $THEME_NAME v$THEME_VERSION"
echo "   Slug    : $THEME_SLUG"
echo "   Source  : $THEME_FILE"
echo "   Output  : $THEME_OUTPUT_DIR"
echo ""

# ── Execute all module scripts ────────────────────────
for script in \
    waybar.sh \
    rofi.sh \
    sway.sh \
    swaync.sh \
    swaylock.sh \
    starship.sh \
    foot.sh \
    fastfetch.sh
do
    path="$SCRIPTS_DIR/$script"
    if [[ -f "$path" ]]; then
        echo "→ Running $script"
        source "$path"
    else
        echo "⚠ Skipping $script (not found)"
    fi
done

# ── Point generated/active → generated/$THEME_SLUG ───
echo ""
echo "→ Updating active theme pointer"
make_link "$OUTPUT_DIR/active" "$THEME_OUTPUT_DIR"

# ── Auto-detect and deploy wallpaper ──────────────────
echo "→ Deploying wallpaper"
_deploy_wallpaper

echo ""
echo "✅  $THEME_NAME is now active"
echo ""
