ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
echo '[+] Enter your hostname'
read hostname
echo ${hostname} >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.0.1 ${hostname}.localdomain ${hostname}" >> /etc/hosts
pacman -S intel-ucode grub dhcpcd efibootmgr vim
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch Linux
grub-mkconfig -o /boot/grub/grub.cfg
echo "[+] please change your root user password then you can reboot your computer"