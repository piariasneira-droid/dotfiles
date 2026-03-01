# ══════════════════════════════════════════════════════
# FOOT — foot.ini
# ══════════════════════════════════════════════════════

write_file "foot/foot.ini" \
"# =====================================================
# $THEME_NAME — Foot Terminal Config
# AUTO-GENERATED — do not edit manually.
# Edit ${THEME_SLUG}.conf and re-run generate.sh
# =====================================================

font=Iosevka Nerd Font:size=10
pad=12x12

[cursor]
style=block
blink=no

[colors]
alpha=0.95
background=$BG0
foreground=$FG0
cursor=$BG0 $FG0

regular0=$BG3
regular1=$RED
regular2=$ACCENT0
regular3=$YELLOW
regular4=$ACCENT_SEC
regular5=$ACCENT_SEC
regular6=$ACCENT1
regular7=$FG1

bright0=$BG2
bright1=$RED
bright2=$ACCENT2
bright3=$ORANGE
bright4=$ACCENT_SEC
bright5=$ACCENT_SEC
bright6=$ACCENT1
bright7=$FG0

[csd]
preferred=server
size=0"

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/foot/foot.ini" \
    "$THEME_OUTPUT_DIR/foot/foot.ini"
