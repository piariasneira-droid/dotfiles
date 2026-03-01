# ══════════════════════════════════════════════════════
# WAYBAR — colors.css
# ══════════════════════════════════════════════════════

write_file "waybar/colors.css" \
"/* =====================================================
 * $THEME_NAME — Waybar Colors
 * AUTO-GENERATED — do not edit manually.
 * Edit ${THEME_SLUG}.conf and re-run generate.sh
 * ===================================================== */

@define-color background           rgba($WB_BACKGROUND);
@define-color transparent          rgba(0, 0, 0, 0);
@define-color tooltip_background   rgba($WB_TOOLTIP_BG);

@define-color on_surface           #$WB_ON_SURFACE;

@define-color primary              #$WB_PRIMARY;
@define-color primary_container    rgba($WB_PRIMARY_CONTAINER);

@define-color tertiary             #$WB_WORKSPACE_HOVER;

@define-color error                #$WB_ERROR;"

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/waybar/colors.css" \
    "$THEME_OUTPUT_DIR/waybar/colors.css"
