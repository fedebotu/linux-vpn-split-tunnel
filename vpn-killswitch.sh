#!/bin/bash

# VPN kill switch script
# This is a VPN kill switch which will cut out all the connections with UFW (Uncomplicated FireWall)
# We add exceptions: in our case, we want ssh on port 2222 to be always allowed

# Ports and protocols to be allowed
ALLOWED_PORTS=('2222/tcp') # example for ssh
VPN_NET_ADAPTER='tun0' # Usually, this is the default
PUBLIC_IP='YOUR_PUBLIC_IP' # Static public IP WITHOUT VPN
SSH_PORT='2222'

echo "Adding iptables rules..."
/bin/bash split-tunnel.sh # refer to script

echo "Adding firewall exceptions..."
for port in "${ALLOWED_PORTS[@]}"
do
    ufw allow "${port}"
done

echo "Allowing traffic on VPN net adapter only"
ufw allow out on ${VPN_NET_ADAPTER} from any to any
ufw allow in on ${VPN_NET_ADAPTER} from any to any

echo "Blocking all traffic by default..."
ufw default deny outgoing
ufw default deny incoming

echo "Enabling firewall..."
ufw enable
ufw status
