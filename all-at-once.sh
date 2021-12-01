#! /bin/bash

# ===== HOST =====
DRIVERS=(
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

pacman -S ${DRIVERS[@]}

# ===== GRUB =====
GRUB=(
    grub
    efibootmgr
    mtools
    dosfstools
    os-prober
    ntfs-3g
)

pacman -S ${GRUB[@]}

# Install GRUB
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# ===== NETWORK =====
NETWORK=(
    networkmanager
    dialog
    firewalld
)

SYS_E_NET=(
    NetworkManager
    firewalld.service
)

pacman -S ${NETWORK[@]}

for system in ${SYS_E_NET[@]}; do
    systemctl enable ${system}
done

#===== BLUETOOTH =====
BLUETOOTH=(
    bluez
    bluez-utils
)

SYS_E_BLUE=(
    bluetooth
)

pacman -S ${BLUETOOTH[@]}

for system in ${SYS_E_BLUE[@]}; do
    systemctl enable ${system}
done

#===== AUDIO =====
AUDIO=(
    alsa-utils
    alsa-plugins

    pipewire
    pipewire-alsa
    pipewire-pulse
    
    sof-firmware
)

pacman -S ${AUDIO[@]}

#===== PRINTING =====
PRINTING=(
    cups
    cups-pdf
    ghostscript
    gsfonts
)

SYS_E_PRINT=(
    cups.service
)

pacman -S ${PRINTING[@]}

for system in ${SYS_E_PRINT[@]}; do
    systemctl enable ${system}
done

#===== USER =====
USER="arch"

useradd -m -g users -G wheel ${USER}
passwd ${USER}
sed -i '/# %wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers

#===== AUR =====
AUR_PACKAGES=(
    cava
    macchina
    brave-bin
    nvim-packer-git
    # zoom
)

sudo pacman -S base-devel --needed

cd /home/${USER}
echo "Installing Yay"
git clone https://aur.archlinux.org/yay.git
cd yay
sudo chown -R ${USER} /home/${USER}/yay
sudo -u ${USER} makepkg -si
cd

sudo -u ${USER} yay -S ${AUR_PACKAGES[@]}

#===== PACKAGES =====
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
    # rustup
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
    reflector


    ###> VIDEO AND AUDIO
    mpv
    mpd
    ncmpcpp

    ###> WINDOW MANAGER
    sway
    swaylock
    swayidle
    waybar
    brightnessctl
    gammastep
    grim
    slurp

    ###> EXTRAS
    discord
    # neomutt
    steam
)

SYS_E_PACKAGES=(
    reflector.timer
)


sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy

pacman -S ${PACKAGES[@]}

for sys in ${SYS_E_PACKAGES[@]}; do
    systemctl enable ${system}
done

reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist