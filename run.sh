#! /bin/bash

# Clean everything up
killall -9 termux-x11 pulseaudio virgl_test_server termux-wake-lock

XDG_RUNTIME_DIR=${TMPDIR}

# Termux-x11
export DISPLAY=:0
termux-x11 :0 &

sleep 3

# Pulseaudio (does not work yet)
# pulseaudio --start --load="module-native-protocol-unix socket=${TMPDIR}/pulse.sock" --exit-idle-time=-1
# pactl load-module module-native-protocol-unix socket=${TMPDIR}/pulse.sock
# export PULSE_SERVER=unix:${TMPDIR}/pulse.sock

# Virgl + zink
MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless &

# Start proot
proot-distro login steam --user root --shared-tmp
