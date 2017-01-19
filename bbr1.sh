cd /lib/firmware
mkdir bnx2
cd bnx2
wget https://raw.githubusercontent.com/xjyxh1/rtinstall/master/bnx2/bnx2-mips-09-6.2.1b.fw
wget https://raw.githubusercontent.com/xjyxh1/rtinstall/master/bnx2/bnx2-mips-06-6.2.3.fw
cd ~
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.2/linux-headers-4.9.2-040902_4.9.2-040902.201701090331_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.2/linux-headers-4.9.2-040902-generic_4.9.2-040902.201701090331_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.2/linux-image-4.9.2-040902-generic_4.9.2-040902.201701090331_amd64.deb
dpkg -i linux-image-4.9.2*.deb
update-grub
