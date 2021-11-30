#! /bin/bash

PACKAGES=(
    alsa-utils
    alsa-plugins

    # pulseaudio
    # pulseaudio-alsa
    # pulseaudio-bluetooth

    pipewire
    pipewire-alsa
    pipewire-pulse
    
    sof-firmware
)

pacman -S ${PACKAGES[@]}