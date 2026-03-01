# ══════════════════════════════════════════════════════
# STARSHIP
# ══════════════════════════════════════════════════════

write_file "starship/starship.toml" \
"# =====================================================
# $THEME_NAME — Starship Prompt
# AUTO-GENERATED — do not edit manually.
# Edit ${THEME_SLUG}.conf and re-run generate.sh
# =====================================================

palette = \"$THEME_SLUG\"

format = \"\"\"
\$username\$directory\$git_branch\$git_status\$git_state\$python\$nodejs\$rust\$golang\$cmd_duration\$jobs\$status
\$character\"\"\"

add_newline = false

[username]
format     = \"[\$user ](\$style)\"
style_user = \"bold fg:#$FG0\"
style_root = \"bold fg:#$RED\"
show_always = true

[directory]
format            = \"[  \$path ](\$style)\"
style             = \"bold fg:#$ACCENT0\"
truncation_length = 4
truncate_to_repo  = true
read_only         = \"  \"
read_only_style   = \"fg:#$RED\"

[directory.substitutions]
\"~/Documentos\" = \"󰈙 Docs\"
\"~/Imagenes\"   = \"󰋩 Imgs\"
\"~\"            = \"󱂵 ~\"

[git_branch]
format = \"[ \$symbol\$branch ](\$style)\"
symbol = \" \"
style  = \"bold fg:#$ACCENT_SEC\"

[git_status]
format    = \"([\$all_status\$ahead_behind ](\$style))\"
style     = \"bold fg:#$ORANGE\"
ahead     = \"⇡\${count}\"
behind    = \"⇣\${count}\"
diverged  = \"⇕⇡\${ahead_count}⇣\${behind_count}\"
modified  = \"!\${count}\"
untracked = \"?\${count}\"
staged    = \"+\${count}\"
deleted   = \"✘\${count}\"
stashed   = \"≡\"

[git_state]
format = \"([\$state( \$progress_current/\$progress_total)](\$style)) \"
style  = \"fg:#$ORANGE\"

[python]
format       = \"[ \${symbol}\${pyenv_prefix}(\${version} )(\\\\(\$virtualenv\\\\) )](\$style)\"
symbol       = \" \"
style        = \"fg:#$ACCENT_SEC\"
detect_files = [\"requirements.txt\", \"pyproject.toml\", \".python-version\", \"setup.py\"]

[nodejs]
format       = \"[ \$symbol(\$version )](\$style)\"
symbol       = \" \"
style        = \"fg:#$ACCENT0\"
detect_files = [\"package.json\", \".nvmrc\"]

[rust]
format       = \"[ \$symbol(\$version )](\$style)\"
symbol       = \" \"
style        = \"fg:#$ORANGE\"
detect_files = [\"Cargo.toml\"]

[golang]
format       = \"[ \$symbol(\$version )](\$style)\"
symbol       = \" \"
style        = \"fg:#$ACCENT_SEC\"
detect_files = [\"go.mod\"]

[cmd_duration]
format            = \"[ 󱦟 \$duration ](\$style)\"
style             = \"fg:#$FG1\"
min_time          = 2000
show_milliseconds = false

[jobs]
format    = \"[ \$symbol\$number ](\$style)\"
symbol    = \" \"
style     = \"fg:#$YELLOW\"
threshold = 1

[status]
format   = \"[ \$symbol\$status ](\$style)\"
symbol   = \" \"
style    = \"fg:#$RED\"
disabled = false

[character]
success_symbol = \"[❯](bold fg:#$ACCENT0)\"
error_symbol   = \"[❯](bold fg:#$RED)\"
vimcmd_symbol  = \"[❮](bold fg:#$ACCENT_SEC)\"

[palettes.$THEME_SLUG]
bg0        = \"#$BG0\"
bg1        = \"#$BG1\"
bg2        = \"#$BG2\"
bg3        = \"#$BG3\"
fg0        = \"#$FG0\"
fg1        = \"#$FG1\"
accent0    = \"#$ACCENT0\"
accent1    = \"#$ACCENT1\"
accent2    = \"#$ACCENT2\"
accent-sec = \"#$ACCENT_SEC\"
orange     = \"#$ORANGE\"
red        = \"#$RED\"
yellow     = \"#$YELLOW\""

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml" \
    "$THEME_OUTPUT_DIR/starship/starship.toml"
