# Parameters
# Parameters
rg=lab-vwan-nexthop

echo Disabling Next Hop IP on NVA VMs

# Disable Next Hop IP on spoke2-linux-nva1
echo Disabling Next Hop IP on spoke2-linux-nva1
scripturi="https://raw.githubusercontent.com/dmauser/azure-virtualwan-nexthop/refs/heads/main/scripts/nonexthopip.sh"
az vm run-command invoke -g $rg -n spoke2-linux-nva1 --command-id RunShellScript --scripts "curl -s $scripturi | bash" --output none --no-wait

# Disable Next Hop IP on spoke2-linux-nva2
echo Disabling Next Hop IP on spoke2-linux-nva2
scripturi="https://raw.githubusercontent.com/dmauser/azure-virtualwan-nexthop/refs/heads/main/scripts/nonexthopip.sh"
az vm run-command invoke -g $rg -n spoke2-linux-nva2 --command-id RunShellScript --scripts "curl -s $scripturi | bash" --output none --no-wait