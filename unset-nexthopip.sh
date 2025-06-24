#!/bin/bash
# Parameters
rg=lab-vwan-nexthop
echo Disabling Next Hop IP on NVA VMs

# Get vHub BGP peer address and display virtual router IPs
neighbor1=$(az network vhub show -g $rg -n hub1 --query virtualRouterIps[0] -o tsv)
neighbor2=$(az network vhub show -g $rg -n hub1 --query virtualRouterIps[1] -o tsv)

# Disable Next Hop IP on spoke2-linux-nva1
echo Disabling Next Hop IP on spoke2-linux-nva1
scripturi="https://raw.githubusercontent.com/dmauser/azure-virtualwan-nexthop/refs/heads/main/scripts/nonexthopip.sh"
az vm run-command invoke -g $rg -n spoke2-linux-nva1 --command-id RunShellScript --scripts "curl -s $scripturi | bash -s -- $neighbor1 $neighbor2" --output none --no-wait

# Disable Next Hop IP on spoke2-linux-nva2
echo Disabling Next Hop IP on spoke2-linux-nva2
scripturi="https://raw.githubusercontent.com/dmauser/azure-virtualwan-nexthop/refs/heads/main/scripts/nonexthopip.sh"
az vm run-command invoke -g $rg -n spoke2-linux-nva2 --command-id RunShellScript --scripts "curl -s $scripturi | bash -s -- $neighbor1 $neighbor2" --output none --no-wait