#!/bin/bash
# VPN kill switch

# Activate VPN

# Ports and protocols to be allowed
VPN_SERVER='jp-tok.prod.surfshark.com_udp' # your VPN server
PSW_FILE="passwd-file"
ALLOWED_PORTS=('1198/udp' '1194/udp' '2222/tcp' '8443/udp' '5800:5810/tcp' '5900:5910/tcp')
VPN_NET_ADAPTER='tun0' # Usually, this is the default
LAN_IP='###.###.###.###/24' # If we want to allow traffic inside of the LAN

echo "Turning on VPN..."
nmcli connection up ${VPN_SERVER} passwd-file ${PSW_FILE}

echo "Enabling ports..."
for port in "${ALLOWED_PORTS[@]}"
do
    ufw allow "${port}"
done

echo "Blocking all traffic..."

# Disable for now
#ufw allow in to ${LAN_IP}
#ufw allow out to ${LAN_IP}
ufw allow out on ${VPN_NET_ADAPTER} from any to any
ufw allow in on ${VPN_NET_ADAPTER} from any to any

ufw default deny outgoing
ufw default deny incoming

ufw enable

ufw status
