#!/bin/bash
rg=lab-vwan-nexthop

# Enable IP Tables 
scripturi="https://raw.githubusercontent.com/dmauser/azure-virtualwan-nexthop/refs/heads/main/scripts/iptables.sh"
az vm run-command invoke -g $rg -n spoke2-linux-nva1 --command-id RunShellScript --scripts "curl -s $scripturi | bash" --output none --no-wait

# Enable IP Tables 
scripturi="https://raw.githubusercontent.com/dmauser/azure-virtualwan-nexthop/refs/heads/main/scripts/iptables.sh"
az vm run-command invoke -g $rg -n spoke2-linux-nva2 --command-id RunShellScript --scripts "curl -s $scripturi | bash" --output none --no-wait

echo The command has completed sucessfully.

