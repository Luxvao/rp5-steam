DISTRO_NAME="Steam installer"

TARBALL_URL['aarch64']="https://github.com/termux/proot-distro/releases/download/v4.17.3/debian-bookworm-aarch64-pd-v4.17.3.tar.xz"
TARBALL_SHA256['aarch64']="3a841a794ae5999b33e33b329582ed0379d4f54ca62c6ce5a8eb9cff5ef8900b"

distro_setup() {
  # Configure en_US.UTF-8 locale.
  sed -i -E 's/#[[:space:]]?(en_US.UTF-8[[:space:]]+UTF-8)/\1/g' ./etc/locale.gen
  run_proot_cmd DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

  # Update packages
  run_proot_cmd apt-get update
  run_proot_cmd apt-get upgrade -y

  # Utils
  run_proot_cmd apt-get install wget git sudo gpg -y

  # Openbox
  run_proot_cmd apt-get install openbox -y

  # Box86
  run_proot_cmd wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
  run_proot_cmd wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | run_proot_cmd gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg
  run_proot_cmd dpkg --add-architecture armhf
  run_proot_cmd apt-get update && run_proot_cmd apt-get install box86-android:armhf -y

  # Box64
  run_proot_cmd wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
  run_proot_cmd wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | run_proot_cmd gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg 
  run_proot_cmd apt-get update && run_proot_cmd apt-get install box64-android -y

  # Steam
  run_proot_cmd git clone https://github.com/ptitSeb/box86
  run_proot_cmd box86/install_steam.sh

  # Steam launcher
  run_proot_cmd cat <<EOF > /root/steam.sh
  # /bin/bash

  export DISPLAY=:0
  export GALLIUM_DRIVER=zink
  export MESA_GL_VERSION_OVERRIDE=4.0

  openbox-session &
  EOF

  run_proot_cmd chmod +x /root/steam.sh

  # Openbox config
  run_proot_cmd cat <<EOF > /etc/xdg/openbox/autostart.sh
  steam &
  EOF
}
