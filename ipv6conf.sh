echo "interface "eno1" {" >>  /etc/dhcp/dhclient6.conf
echo "   send dhcp6.client-id 00:03:00:01:bc:74:1f:93:08:60;" >>  /etc/dhcp/dhclient6.conf
echo "}" >>  /etc/dhcp/dhclient6.conf

echo "[Unit]" >> /etc/systemd/system/dhclient.service
echo "Description=dhclient for sending 00:03:00:01:bc:74:1f:93:08:60 IPv6" >> /etc/systemd/system/dhclient.service
echo "Wants=network.target" >> /etc/systemd/system/dhclient.service
echo "Before=network.target" >> /etc/systemd/system/dhclient.service
echo "" >> /etc/systemd/system/dhclient.service
echo "[Service]" >> /etc/systemd/system/dhclient.service
echo "Type=forking" >> /etc/systemd/system/dhclient.service
echo "ExecStart=/usr/sbin/dhclient -cf /etc/dhcp/dhclient6.conf -6 -P -v eno1" >> /etc/systemd/system/dhclient.service
echo "" >> /etc/systemd/system/dhclient.service
echo "[Install]" >> /etc/systemd/system/dhclient.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/dhclient.service

systemctl enable dhclient.service

echo "iface eno1 inet6 static" >> /etc/network/interfaces
echo "    address 2001:bc8:2664:200::1" >> /etc/network/interfaces
echo "    netmask 56" >> /etc/network/interfaces

ip6tables -A OUTPUT -p udp --dport 547 -m limit --limit 10/min --limit-burst 5 -j ACCEPT
ip6tables -A OUTPUT -p udp --dport 547 -j DROP
