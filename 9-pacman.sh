#! /bin/bash

PACKAGES=(
    ###> DEVELOPMENT
    neovim
    clang
    cmake
    gcc
    zig
    rustup

    ###> TERMINAL UTILITIES
    ripgrep
    sd
    bat
    curl
    wget
    glances
    htop
    ranger
    zoxide
    exa
    rsync
    unrar
    unzip
    zip
    stow
    starship


    ###> VIDEO AND AUDIO
    mpv
    mpd
    ncmpcpp

    ###> WINDOW MANAGER
    sway
    swaylock
    brightnessctl
    gammastep
    grim
    slurp

    ###> EXTRAS
    discord
    steam
)

sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy

pacman -S ${PACKAGES[@]}