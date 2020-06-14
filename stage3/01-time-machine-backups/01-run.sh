#!/bin/bash -e

# Set up Time Machine backups
echo "Installing Samba config and Avahi service"
cat << EOF >> "${ROOTFS_DIR}/etc/samba/smb.conf"
[backups]
   comment = Backups
   path = /media/backups
   valid users = ${FIRST_USER_NAME}
   read only = no
   vfs objects = catia fruit streams_xattr
   fruit:time machine = yes
EOF
install -m 644 files/samba.service "${ROOTFS_DIR}/etc/avahi/services"

echo "Adding external drive to /etc/fstab"
echo "UUID=${EXTERNAL_DRIVE_UUID}       /media  ext4    sync,noexec,nodev,noatime,nodiratime    0       0" >> "${ROOTFS_DIR}/etc/fstab"

echo "Configuring external drive spindown time"
cat << EOF >> "${ROOTFS_DIR}/etc/hdparm.conf"
/dev/disk/by-uuid/${EXTERNAL_DRIVE_UUID} {
	spindown_time = 120
}
EOF

echo "Adding ${FIRST_USER_NAME} as Samba user"
on_chroot << EOF
(echo "${FIRST_USER_PASS}"; echo "${FIRST_USER_PASS}") | smbpasswd -s -a "${FIRST_USER_NAME}"
EOF
