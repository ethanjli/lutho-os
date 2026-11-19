#!/bin/bash
tee /etc/yum.repos.d/netbird.repo <<EOF
[netbird]
name=netbird
baseurl=https://pkgs.netbird.io/yum/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.netbird.io/yum/repodata/repomd.xml.key
repo_gpgcheck=1
EOF

# from https://discussion.fedoraproject.org/t/fedora-bootc-how-to-install-netbird/196331/3
tee /etc/systemd/system/netbird.service <<EOF
[Unit]
Description=NetBird mesh network client
ConditionFileIsExecutable=/usr/bin/netbird
After=network.target syslog.target

[Service]
StartLimitInterval=5
StartLimitBurst=10

ExecStart=/usr/bin/netbird "service" "run" "--log-level" "info" "--daemon-addr" "unix:///var/run/netbird.sock" "--log-file" "/var/log/netbird/client.log"

Restart=always
RestartSec=120
EnvironmentFile=-/etc/sysconfig/netbird
Environment=SYSTEMD_UNIT=netbird

[Install]
WantedBy=multi-user.target
EOF

# for CLI only
dnf --setopt=tsflags=noscripts install -y netbird
systemctl enable netbird.service
# for the desktop app
dnf install -y netbird-ui gtk4 webkitgtk6.0 xdg-utils
