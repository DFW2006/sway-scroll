#!/bin/bash

# Toggle logic: If Fuzzel is already running, kill it and exit
if pgrep -x "fuzzel" > /dev/null; then
    pkill -x "fuzzel"
    exit 0
fi

# Function to ask for confirmation before dangerous actions
confirm_action() {
    local action="$1"
    CONFIRMATION="$(printf "No\nYes" | fuzzel --dmenu -a top-right -l 2 -w 18 -p "$action?")"
    [[ "$CONFIRMATION" == *"Yes"* ]]
}

# Main selection menu
SELECTION="$(printf "󰌾 Lock\n󰤄 Suspend\n󰍃 Log out\n Reboot\n Reboot to UEFI\n󰐥 Shutdown" | fuzzel --dmenu -a top-right -l 6 -w 18 -p "Select an option: ")"

# Logic for each button (using wildcards to ensure it matches icons)
case "$SELECTION" in
    *Lock*)
        gtklock;;
    *Suspend*)
        if confirm_action "Suspend"; then
            systemctl suspend
        fi;;
    *Log*)
        if confirm_action "Log out"; then
            swaymsg exit
        fi;;
    *Reboot*)
        # Check if it's Reboot to UEFI or normal Reboot
        if [[ "$SELECTION" == *"UEFI"* ]]; then
            if confirm_action "Reboot to UEFI"; then
                systemctl reboot --firmware-setup
            fi
        else
            if confirm_action "Reboot"; then
                systemctl reboot
            fi
        fi;;
    *Shutdown*)
        if confirm_action "Shutdown"; then
            systemctl poweroff
        fi;;
esac
