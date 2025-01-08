#! /bin/bash

# Termux-x11
export DISPLAY=:0
termux-x11 :0 &

# Pulseaudio
pulseaudio --start &
pactl load-module module-native-protocol-unix socket=$PREFIX/tmp/pulse.sock
export PULSE_SERVER=unix:$PREFIX/tmp/pulse.sock

# Virgl + zink
MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless &

# Start proot
proot-distro login steam --user root --shared-tmp
