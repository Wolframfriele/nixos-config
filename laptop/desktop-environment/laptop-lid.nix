{ pkgs, ... }:

pkgs.writeShellScriptBin "laptop-lid" ''
# turn on laptop display
if grep open /proc/acpi/button/lid/LID0/state; then
    hyprctl keyword monitor "eDP-1,1920x1080@60,3840x1080,1"
    # killall .waybar-wrapped
    # waybar & disown
else
    if [[ `hyprctl monitors | grep "Monitor" | wc -l` != 1 ]]; then
        hyprctl keyword monitor "eDP-1, disable"
        # killall .waybar-wrapped
        # waybar & disown
    fi
fi
''
