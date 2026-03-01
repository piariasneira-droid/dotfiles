# ══════════════════════════════════════════════════════
# SWAYNC — style.css
# ══════════════════════════════════════════════════════

write_file "swaync/style.css" \
"/* =====================================================
 * $THEME_NAME — SwayNC Style
 * AUTO-GENERATED — do not edit manually.
 * Edit ${THEME_SLUG}.conf and re-run generate.sh
 * ===================================================== */

* {
    font-family: \"JetBrainsMono Nerd Font\", monospace;
    font-size:   14px;
    transition:  all 0.2s ease;
}

.control-center {
    background-color: rgba($BG0_A95);
    border:           1px solid #$ACCENT0;
    border-radius:    14px;
    padding:          8px;
    color:            #$FG0;
}

.control-center-list { background-color: transparent; }

.notification-row { outline: none; padding: 4px 8px; }
.notification-row:focus,
.notification-row:hover { background: transparent; }

.notification {
    background-color: #$BG1;
    border-radius:    12px;
    border:           1px solid #$BG3;
    padding:          8px;
    margin:           4px 0px;
    color:            #$FG0;
}
.notification:hover { border-color: #$ACCENT0; }

.notification.low      { border-left: 3px solid #$ACCENT1; }
.notification.normal   { border-left: 3px solid #$ACCENT0; }
.notification.critical {
    border-left:      3px solid #$RED;
    background-color: rgba($BG0_A90);
}

.notification-default-action {
    background: transparent; border-radius: 12px; padding: 4px; color: #$FG0;
}
.notification-default-action:hover { background: rgba($ACCENT0_A15); }

.notification-content { background: transparent; padding: 4px 0px; }

.app-name  { color: #$ACCENT0; font-weight: bold; font-size: 13px; }
.app-icon  { -gtk-icon-size: 20px; }
.timestamp { color: #$FG1; font-size: 11px; }
.summary   { color: #$FG0; font-weight: bold; font-size: 14px; padding-top: 2px; }
.body      { color: #$FG1; font-size: 13px; }

.close-button {
    background: #$BG3; color: #$FG1; border-radius: 6px; border: none; padding: 2px 6px;
}
.close-button:hover { background: #$RED; color: #$BG0; }

.notification-action {
    background: #$BG2; border-radius: 8px; border: 1px solid #$BG3;
    color: #$FG0; padding: 4px 10px; margin: 4px 2px 0px;
}
.notification-action:hover { background: #$ACCENT0; color: #$BG0; border-color: #$ACCENT0; }

.widget-title { background: transparent; padding: 6px 12px; margin-bottom: 4px; }
.widget-title > label { color: #$ACCENT0; font-size: 16px; font-weight: bold; }
.widget-title > button {
    background: #$BG2; border-radius: 8px; border: 1px solid #$BG3;
    color: #$FG1; padding: 4px 10px; font-size: 12px;
}
.widget-title > button:hover { background: #$RED; color: #$BG0; border-color: #$RED; }

.widget-dnd {
    background: #$BG1; border-radius: 10px; padding: 6px 12px; margin-bottom: 6px; color: #$FG0;
}
.widget-dnd > switch { border-radius: 20px; background: #$BG3; border: 1px solid #$BG3; }
.widget-dnd > switch:checked { background: #$RED; border-color: #$RED; }
.widget-dnd > switch slider {
    background: #$FG0; border-radius: 50%; min-width: 18px; min-height: 18px;
}

.widget-mpris {
    background: #$BG1; border-radius: 10px; padding: 8px 12px;
    margin-bottom: 6px; color: #$FG0; border: 1px solid #$BG3;
}
.widget-mpris-player { background: transparent; padding: 4px; }
.widget-mpris-title  { color: #$FG0; font-weight: bold; }
.widget-mpris-subtitle { color: #$FG1; }

.inline-reply { margin-top: 8px; }
.inline-reply-entry {
    background: #$BG2; color: #$FG0; border-radius: 8px;
    border: 1px solid #$BG3; padding: 4px 8px;
}
.inline-reply-entry:focus { border-color: #$ACCENT0; }
.inline-reply-button {
    background: #$ACCENT0; color: #$BG0; border-radius: 8px;
    border: none; padding: 4px 10px; font-weight: bold;
}
.inline-reply-button:hover { background: #$ACCENT2; }"

# ── Deploy ────────────────────────────────────────────
# style.css is theme-specific — symlink the generated one
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/swaync/style.css" \
    "$THEME_OUTPUT_DIR/swaync/style.css"

# config.json is static (layout/widgets, not colors)
# symlink it from the scripts dir so it's tracked in your dotfiles
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/swaync/config.json" \
    "$THEME_DIR/swaync/config.json"
