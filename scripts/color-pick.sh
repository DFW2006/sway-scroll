#!/bin/bash

HEX=$(grim -g "$(slurp -p)" -t ppm - | magick - -format '%[hex:u.p{0,0}]' info:- 2>/dev/null)

if [ -z "$HEX" ]; then
    notify-send "Color Picker" "Failed to pick color" --urgency=low
    exit 1
fi

HEX="${HEX:0:6}"
notify-send "Color Picker" "Picked #$HEX" --urgency=low

matugen color hex "#$HEX"

# restart waybar
killall waybar
waybar -c ~/.config/waybar/scroll/config.jsonc -s ~/.config/waybar/scroll/style.css &

# reload sway colors
if [ -f ~/.cache/matugen/sway-colors ]; then
    while IFS= read -r line; do
        swaymsg "$line"
    done < ~/.cache/matugen/sway-colors
fi

# reload nvim in all running instances
for server in $(nvim --server-list 2>/dev/null); do
    nvim --server "$server" --remote-send '<cmd>source ~/.config/nvim/lua/plugins/colorscheme.lua<cr>' 2>/dev/null
done

notify-send "Theme" "Applied theme from #$HEX" --urgency=low
