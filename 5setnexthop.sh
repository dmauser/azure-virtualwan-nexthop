#!/bin/bash
# Parameters
rg=lab-vwan-nexthop

echo Configuring Next Hop IP on NVA VMs

# Get load balancer spoke2-linux-nva-ilb ip address
nvalbip=$(az network lb frontend-ip list -g $rg --lb-name spoke2-linux-nva-ilb --query "[?contains(name, 'frontend')].{Name:privateIPAddress}" -o tsv)

# Get vHub BGP peer address and display virtual router IPs
neighbor1=$(az network vhub show -g $rg -n hub1 --query virtualRouterIps[0] -o tsv)
neighbor2=$(az network vhub show -g $rg -n hub1 --query virtualRouterIps[2] -o tsv)


# Configure Next Hop IP on spoke2-linux-nva1
echo Configuring Next Hop IP on spoke2-linux-nva1
scripturi="https://raw.githubusercontent.com/dmauser/azure-virtualwan-nexthop/refs/heads/main/scripts/nexthopip.sh"
az vm run-command invoke -g $rg -n spoke2-linux-nva1 --command-id RunShellScript --scripts "curl -s $scripturi | bash -s -- $nvalbip $neighbor1 $neighbor2" --output none --no-wait

# Configure Next Hop IP on spoke2-linux-nva1
echo Configuring Next Hop IP on spoke2-linux-nva2
scripturi="https://raw.githubusercontent.com/dmauser/azure-virtualwan-nexthop/refs/heads/main/scripts/nexthopip.sh"
az vm run-command invoke -g $rg -n spoke2-linux-nva2 --command-id RunShellScript --scripts "curl -s $scripturi | bash -s -- $nvalbip $neighbor1 $neighbor2" --output none --no-wait

echo The command has completed sucessfully.