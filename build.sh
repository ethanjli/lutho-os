#!/bin/bash

set -ouex pipefail

# prepare to install userspace tablet driver
# note: the user needs to manually enable the systemctl service according to https://opentabletdriver.net/Wiki/FAQ/Linux#autostart
wget https://github.com/OpenTabletDriver/OpenTabletDriver/releases/latest/download/OpenTabletDriver.rpm -O /tmp/opentabletdriver.rpm

rpm-ostree install \
  acpica-tools \
  kio-fuse \
  /tmp/opentabletdriver.rpm

# install zerotier
# note: the install script exits with error 1 when it realized that systemd isn't running.
cp /usr/lib/os-release /etc/os-release # the zerotier installer script checks /etc/os-release, which doesn't exist
curl -s https://install.zerotier.com | (sudo bash || echo "We assume that ZeroTier has installed successfully!")
rm /etc/os-release
