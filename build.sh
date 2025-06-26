#!/bin/bash

set -ouex pipefail

rpm-ostree install acpica-tools

# Better remote filesystem support:
rpm-ostree install kio-fuse

# Smart card support for Yubico Authenticator:
rpm-ostree install pcsc-lite

# Calendar integration (they didn't work via Flatpak):
rpm-ostree install \
  merkuro kdepim-addons kdepim-runtime \
  qt6-qtlocation # required dependency for merkuro

# install zerotier
/tmp/install-zerotier.sh
