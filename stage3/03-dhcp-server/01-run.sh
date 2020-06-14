#!/bin/bash -e

# Set up DHCP server
echo "Setting up DHCP server"
install -m 644 files/dhcpd.conf "${ROOTFS_DIR}/etc/dhcp/"
sed "${ROOTFS_DIR}/etc/default/isc-dhcp-server" -i -e 's|INTERFACESv4=""|INTERFACESv4="eth0"|'
