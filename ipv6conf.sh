INTERFACE=$1
BLOCK_ADDR=$2
BLOCK_DUID=$3

read -p "Your Interface: " INTERFACE
read -p "Your IPv6 block address (e.g. 2001:bb8:3e23:200::1): " BLOCK_ADDR
read -p "Associated DUID (e.g. 00:03:00:00:34:b0:0c:47:4a:0e): " BLOCK_DUID

echo "interface "$INTERFACE" {" >>  /etc/dhcp/dhclient6.conf
echo "   send dhcp6.client-id $BLOCK_DUID;" >>  /etc/dhcp/dhclient6.conf
echo "}" >>  /etc/dhcp/dhclient6.conf

dhclient -cf /etc/dhcp/dhclient6.conf -6 -P -v $INTERFACE
/sbin/ifconfig $INTERFACE inet6 add $BLOCK_ADDR/56
