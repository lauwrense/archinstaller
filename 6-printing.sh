#! /bin/bash
PACKAGES=(
    cups
    cups-pdf
    ghostscript
    gsfonts
)

SYS_E=(
    cups.service
)

pacman -S ${PACKAGES[@]}

for system in ${SYS_E[@]}; do
    systemctl enable ${system}
done