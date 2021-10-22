#!/bin/bash

# We search for specific rules in iptables: if they are not found in the right position, then we add them
# We want to allow port 2222 as ssh port in this case
# You may want to run this as a crontab to fix iptables regularly in case of other programs messing with them (e.g. VPNs)
# NOTE: Remember to use the ssh-no-vpn.sh script for marking the ssh traffic in case of VPN connections! 
# Otherwise, the following will have no effect

echo "Checking rules..."

# Check input connection
iptables -L --line-numbers | grep '1    ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:2222 ctstate NEW,ESTABLISHED'
if [ $? -ne 0 ]; then
    echo "Rule not found. Inserting it on top of the iptables..."
    iptables -I INPUT -p tcp --dport 2222 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
else
    echo "Rule found."
fi

# Check output connection
iptables -L --line-numbers | grep '1    ACCEPT     tcp  --  anywhere             anywhere             tcp spt:2222 ctstate ESTABLISHED'
if [ $? -ne 0 ]; then
    echo "Rule not found. Inserting it on top of the iptables..."
    iptables -I OUTPUT -p tcp --sport 2222 -m conntrack --ctstate ESTABLISHED -j ACCEPT
else
    echo "Rule found."
fi

echo "Done!"
