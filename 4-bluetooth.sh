#! /bin/bash
PACKAGES=(
    bluez
    bluez-utils
)

SYS_E=(
    bluetooth
)

pacman -S ${PACKAGES[@]}

for system in ${SYS_E[@]}; do
    systemctl enable ${system}
done