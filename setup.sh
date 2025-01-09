#! /bin/bash

# Set up termux
pkg update
termux-setup-storage
pkg install x11-repo
pkg install proot-distro pulseaudio termux-x11-nightly

# Steam setup
cp steam.sh $PREFIX/etc/proot-distro/
proot-distro install steam

# virglrenderer + zink
pkg install tur-repo
pkg update -y && pkg upgrade -y
pkg install mesa-zink virglrenderer-mesa-zink vulkan-loader-android
