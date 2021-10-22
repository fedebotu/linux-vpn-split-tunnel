# 🔀 Linux VPN Split Tunneling

[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](https://github.com/ellerbrock/open-source-badges/)


Bash scripts for enabling custom split tunneling for VPNs in Linux. 

## ⚙️ Instructions
1.  Modify the scripts with your configuration
2.  Make the target script executable, e.g. `sudo chmod u+x split-tunnel.sh`
3.  Run! E.g. `./split-tunnel.sh`

## 🗂 Contents
- `split-tunnel.sh`: allow traffic on specific port with VPN on
- `search-fix-iptables.sh`: fix iptables iteratively by checking if rules are present in the right position
- `vpn-killswitch.sh`: custom killswitch based on `ufw`

## 📬 Feedback
If you would like to contribute, do not hesitate to open issues or pull requests!
