#! /bin/bash

PACKAGES=(
    ###> DEVELOPMENT
    kitty
    neovim
    nodejs
    # electron
    npm
    yarn
    clang
    cmake
    gcc
    zig
    rustup
    go
    docker
    # godot

    ###> TERMINAL UTILITIES
    ripgrep
    sd
    bat
    thefuck
    tldr
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
    bitwarden-cli
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
    # neomutt
    steam
)

sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy

pacman -S ${PACKAGES[@]}