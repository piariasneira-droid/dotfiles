# ══════════════════════════════════════════════════════
# SWAYLOCK — config
# ══════════════════════════════════════════════════════

write_file "swaylock/config" \
"# =====================================================
# $THEME_NAME — Swaylock Config
# AUTO-GENERATED — do not edit manually.
# Edit ${THEME_SLUG}.conf and re-run generate.sh
# =====================================================

# ── Appearance ────────────────────────────────────────
ignore-empty-password
show-failed-attempts
daemonize

# ── Colors (no # prefix in swaylock config) ───────────

# Background
color=$BG0

# Ring
ring-color=$ACCENT1
ring-ver-color=$ACCENT2
ring-wrong-color=$RED
ring-clear-color=$ACCENT_SEC

# Inside circle
inside-color=$BG0
inside-ver-color=$BG1
inside-wrong-color=$BG2
inside-clear-color=$BG1

# Key press highlight
key-hl-color=$ACCENT0
bs-hl-color=$RED

# Separator
separator-color=00000000

# Text
text-color=$FG0
text-ver-color=$FG0
text-wrong-color=$RED
text-clear-color=$FG1

# Line (border between inside and ring)
line-color=00000000
line-ver-color=00000000
line-wrong-color=00000000
line-clear-color=00000000"

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/swaylock/config" \
    "$THEME_OUTPUT_DIR/swaylock/config"
