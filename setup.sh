#! /bin/bash

# Set up termux
pkg update
termux-setup-storage
pkg install proot-distro pulseaudio termux-x11-nightly

# Download distro
proot-distro install debian

# virglrenderer + zink
pkg install tur-repo
pkg update -y && pkg upgrade -y
pkg install mesa-zink virglrenderer-mesa-zink vulkan-loader-android
