#! /bin/bash
read -p "ENTER SUPERUSER" USER

AUR_PACKAGES=(
    cava
    macchina
    brave-bin
    nvim-packer-git
    # zoom
)

cd /home/${USER}
echo "Installing Yay"
git clone https://aur.archlinux.org/yay.git
cd yay
sudo chown -R ${USER} /home/${USER}/yay
sudo -u ${USER} makepkg -si
cd

sudo -u ${USER} yay -S ${AUR_PACKAGES[@]}