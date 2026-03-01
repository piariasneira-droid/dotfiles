# ══════════════════════════════════════════════════════
# FASTFETCH — config.jsonc
# ══════════════════════════════════════════════════════

write_file "fastfetch/config.jsonc" \
"{
    \"\$schema\": \"https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json\",
    \"logo\": {
        \"padding\": { \"top\": 2 },
        \"color\":   { \"1\": \"32\" }
    },
    \"display\": {
        \"separator\": \" ➜  \"
    },
    \"modules\": [
        \"title\",
        \"separator\",
        { \"type\": \"os\",       \"key\": \"󰣇 OS\",  \"keyColor\": \"green\" },
        { \"type\": \"kernel\",   \"key\": \"󰒋 Ker\", \"keyColor\": \"green\" },
        { \"type\": \"uptime\",   \"key\": \"󰅐 Up\",  \"keyColor\": \"green\" },
        { \"type\": \"packages\", \"key\": \"󰏖 Pkg\", \"keyColor\": \"green\" },
        \"break\",
        { \"type\": \"shell\",    \"key\": \"󱆃 Sh\",  \"keyColor\": \"cyan\" },
        { \"type\": \"terminal\", \"key\": \"󰆍 Trm\", \"keyColor\": \"cyan\" },
        { \"type\": \"wm\",       \"key\": \"󱂵 WM\",  \"keyColor\": \"cyan\" },
        \"break\",
        { \"type\": \"cpu\",      \"key\": \"󰻠 CPU\", \"keyColor\": \"yellow\" },
        { \"type\": \"memory\",   \"key\": \"󰍛 Mem\", \"keyColor\": \"yellow\" },
        { \"type\": \"disk\",     \"key\": \"󰋊 Dsk\", \"keyColor\": \"yellow\" },
        \"break\",
        { \"type\": \"colors\",   \"symbol\": \"circle\" }
    ]
}"

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/config.jsonc" \
    "$THEME_OUTPUT_DIR/fastfetch/config.jsonc"
