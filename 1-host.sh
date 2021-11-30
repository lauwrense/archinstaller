#! /bin/bash

PACKAGES=(
    amd-ucode
    # intel-ucode
    mesa

    base-devel
    linux-headers
)

# Set time zone and locale
timedatectl set-ntp true
ln -sf usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc
sh -sc "sed -i '/${LOCALE}/s/^#//' /etc/locale.gen"
locale-gen

# Set host
echo "${HOSTNAME}" >>/etc/hostname
echo "127.0.0.1 localhost" >>/etc/hosts
echo "::1       localhost" >>/etc/hosts
echo "127.0.1.1 ${HOSTNAME}.localdomain ${HOSTNAME}" >>/etc/hosts
passwd root

pacman -S ${PACKAGES[@]}
