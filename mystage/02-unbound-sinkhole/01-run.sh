#!/bin/bash -e

# Set up Unbound sinkhole
echo "Installing Unbound configuration"
install -m 644 files/sinkhole.conf "${ROOTFS_DIR}/etc/unbound/unbound.conf.d/"
install -m 644 files/root.hints "${ROOTFS_DIR}/var/lib/unbound/"
install -m 755 files/update-unbound-root-hints.sh "${ROOTFS_DIR}/etc/cron.monthly/"

install -d "${ROOTFS_DIR}/etc/unbound/lists.d"
install -m 644 files/01-safelist.conf "${ROOTFS_DIR}/etc/unbound/lists.d"
install -m 644 files/02-blocklist.conf "${ROOTFS_DIR}/etc/unbound/lists.d"

install -d "${ROOTFS_DIR}/opt/blocklists"
install -m 755 files/blocklist.sh "${ROOTFS_DIR}/opt/blocklists/"
install -m 755 files/safelist.sh "${ROOTFS_DIR}/opt/blocklists/"
install -m 755 files/update-blocklists.sh "${ROOTFS_DIR}/etc/cron.weekly/"
