wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.2/linux-headers-4.9.2-040902_4.9.2-040902.201701090331_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.2/linux-headers-4.9.2-040902-generic_4.9.2-040902.201701090331_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.2/linux-image-4.9.2-040902-generic_4.9.2-040902.201701090331_amd64.deb
dpkg -i linux-image-4.9.0*.deb
update-grub
