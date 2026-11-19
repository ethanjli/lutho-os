#!/bin/bash
sudo tee /etc/yum.repos.d/netbird.repo <<EOF
[netbird]
name=netbird
baseurl=https://pkgs.netbird.io/yum/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.netbird.io/yum/repodata/repomd.xml.key
repo_gpgcheck=1
EOF

# for CLI only
dnf5 install -y netbird
# for the desktop app
dnf5 install -y netbird-ui gtk4 webkitgtk6.0 xdg-utils
