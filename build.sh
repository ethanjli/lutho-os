#!/bin/bash

set -ouex pipefail

# prepare to install userspace tablet driver (this works, and I couldn't get the Flatpak to work standalone)
# note: the user needs to manually enable the systemctl service according to https://opentabletdriver.net/Wiki/FAQ/Linux#autostart
wget https://github.com/OpenTabletDriver/OpenTabletDriver/releases/latest/download/OpenTabletDriver.rpm -O /tmp/opentabletdriver.rpm
for c in /etc/udev/rules.d/*-opentabletdriver.rules; do
  if [ -f "${c}" ]; then
    echo "Copying ${c} into /usr"
    cp "$c" "/usr/${c}"
  fi
done

rpm-ostree install \
  acpica-tools \
  kio-fuse \
  /tmp/opentabletdriver.rpm \
  merkuro kdepim-addons kdepim-runtime # I couldn't get these integrations to work via Flatpak

# install zerotier
/tmp/install-zerotier.sh
