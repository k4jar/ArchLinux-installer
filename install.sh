#!/bin/bash

timedatectl set-ntp true
fdisk -l
echo '[+] put in the disk name that you want to install your Atch like "/dev/sda"'
read disk_name
umount /dev/sda1
umount /dev/sda3
swapoff /dev/sda2
echo "g
n


+1G
n


+2G
n



w" | fdisk ${disk_name} 
mkfs.ext4 ${disk_name}3
mkfs.fat -F32 ${disk_name}1
mkswap ${disk_name}2
swapon ${disk_name}2
mount ${disk_name}3 /mnt
mkdir /mnt/boot
mount ${disk_name}1 /mnt/boot
reflector --country China --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
mv arch-chroot.sh /mnt/
arch-chroot /mnt
