#! /bin/bash

PACKAGES=(
    grub
    efibootmgr
    mtools
    dosfstools
    os-prober
    ntfs-3g
)

pacman -S ${PACKAGES[@]}

# Install GRUB
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg