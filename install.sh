#!/bin/bash
function network()
{
	local timeout=1
	local target=www.baidu.com
	local ret_code=`curl -I -s --connect-timeout ${timeout} ${target} -w %{http_code} | tail -n1`
	if [ "${ret_code}" = "200" ];
	then
		echo '[+] online'
	else
		echo '[+] offline'
		exit
	fi
}
network
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
reflector --country China --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base linux
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt