#!/bin/bash

set -ouex pipefail

dnf5 install -y acpica-tools

# Better remote filesystem support:
dnf5 install -y kio-fuse

# Smart card support for Yubico Authenticator:
dnf5 install -y pcsc-lite

# Calendar integration (they didn't work via Flatpak):
dnf5 install -y \
  merkuro kdepim-addons kdepim-runtime \
  qt6-qtlocation # required dependency for merkuro

# install zerotier
/tmp/install-zerotier.sh
