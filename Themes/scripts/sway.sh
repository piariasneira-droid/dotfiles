# ══════════════════════════════════════════════════════
# SWAY — colors.conf
# ══════════════════════════════════════════════════════

write_file "sway/colors.conf" \
"### =====================================================
### $THEME_NAME — Sway Border Colors
### AUTO-GENERATED — do not edit manually.
### Edit ${THEME_SLUG}.conf and re-run generate.sh
### =====================================================

### Class                  Border      Background  Text    Indicator     Child_Border
client.focused              #$ACCENT0  #$BG2       #$FG0   #$ACCENT_SEC  #$ACCENT0
client.focused_inactive     #$BG3      #$BG2       #$FG1   #$BG3         #$BG3
client.unfocused            #$BG0      #$BG0       #$FG1   #$BG0         #$BG0
client.urgent               #$RED      #$RED       #$FG0   #$RED         #$RED
client.placeholder          #$BG0      #$BG0       #$FG1   #$BG0         #$BG0"

# ── Deploy ────────────────────────────────────────────
# Sway loads colors via the active/ symlink in 05-appearance.conf
# No direct ~/.config/sway symlink needed — generate.sh handles active/
