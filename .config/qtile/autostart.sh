#!/usr/bin/env bash 

lxsession &
picom &
#conky -c $HOME/.config/conky/doomone-qtile.conkyrc
volumeicon &
nm-applet &

# Dual displays
xrandr --output eDP-1-1 --auto --output HDMI-0 --auto --right-of eDP-1-1 &

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
# xargs xwallpaper --stretch < ~/.xwallpaper &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
nitrogen --restore &
