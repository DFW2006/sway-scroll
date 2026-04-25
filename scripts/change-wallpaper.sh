#!/bin/bash
WALLPAPER="${1/#\~/$HOME}"
matugen image "$WALLPAPER"

killall waybar
waybar -c ~/.config/waybar/scroll/config.jsonc -s ~/.config/waybar/scroll/style.css &

if [ -f ~/.cache/matugen/sway-colors ]; then
    while IFS= read -r line; do
        swaymsg "$line"
    done < ~/.cache/matugen/sway-colors
fi

for server in $(nvim --server-list 2>/dev/null); do
    nvim --server "$server" --remote-send '<cmd>source ~/.config/nvim/lua/plugins/colorscheme.lua<cr>' 2>/dev/null
done
