#!/bin/bash -e

# Set up static IP
echo "Writing static IP config to /etc/dhcpcd.conf"
cat << EOF >> "${ROOTFS_DIR}/etc/dhcpcd.conf"
interface eth0
static ip_address=192.168.1.116/24
static routers=192.168.1.254
static domain_name_servers=192.168.1.254
EOF
