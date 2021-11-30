#! /bin/bash
PACKAGES=(
    networkmanager
    dialog
)

SYS_E=(
    NetworkManager
)

pacman -S ${PACKAGES[@]}

for system in ${SYS_E[@]}; do
    systemctl enable ${system}
done