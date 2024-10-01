#!/bin/bash

set -ouex pipefail

rpm-ostree install \
  acpica-tools \
  kio-fuse \
  merkuro kdepim-addons kdepim-runtime # I couldn't get these integrations to work via Flatpak
