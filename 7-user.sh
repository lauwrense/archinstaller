#! /bin/bash
read -p "ENTER SUPERUSER" USER

useradd -m -g users -G wheel ${USER}
passwd ${USER}
sed -i '/# %wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers