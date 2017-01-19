INTERFACE=$1
BLOCK_ADDR=$2
BLOCK_DUID=$3

read -p "Your Interface: " INTERFACE
read -p "Your IPv6 block address (e.g. 2001:bb8:3e23:200::1): " BLOCK_ADDR
read -p "Associated DUID (e.g. 00:03:00:00:34:b0:0c:47:4a:0e): " BLOCK_DUID

echo "interface "$INTERFACE" {" >>  /etc/dhcp/dhclient6.conf
echo "   send dhcp6.client-id $BLOCK_DUID;" >>  /etc/dhcp/dhclient6.conf
echo "}" >>  /etc/dhcp/dhclient6.conf

echo "[Unit]" >> /etc/systemd/system/dhclient.service
echo "Description=dhclient for sending $BLOCK_DUID IPv6" >> /etc/systemd/system/dhclient.service
echo "Wants=network.target" >> /etc/systemd/system/dhclient.service
echo "Before=network.target" >> /etc/systemd/system/dhclient.service
echo "" >> /etc/systemd/system/dhclient.service
echo "[Service]" >> /etc/systemd/system/dhclient.service
echo "Type=forking" >> /etc/systemd/system/dhclient.service
echo "ExecStart=/usr/sbin/dhclient -cf /etc/dhcp/dhclient6.conf -6 -P -v $INTERFACE" >> /etc/systemd/system/dhclient.service
echo "" >> /etc/systemd/system/dhclient.service
echo "[Install]" >> /etc/systemd/system/dhclient.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/dhclient.service

systemctl enable dhclient.service

echo "iface $INTERFACE inet6 static" >> /etc/network/interfaces
echo "    address $BLOCK_ADDR" >> /etc/network/interfaces
echo "    netmask 56" >> /etc/network/interfaces

ip6tables -A OUTPUT -p udp --dport 547 -m limit --limit 10/min --limit-burst 5 -j ACCEPT
ip6tables -A OUTPUT -p udp --dport 547 -j DROP
