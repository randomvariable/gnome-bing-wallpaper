#!/bin/bash
# export DBUS_SESSION_BUS_ADDRESS environment variable
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
cd /home/naadir/linspace/notwindows-bing-wallpaper
bundle exec ruby wallpaper.rb
