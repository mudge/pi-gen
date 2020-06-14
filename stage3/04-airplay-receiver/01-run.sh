#!/bin/bash -e

# Set up volume
echo "Setting volume"
install -m 644 files/asound.state "${ROOTFS_DIR}/var/lib/alsa/"
