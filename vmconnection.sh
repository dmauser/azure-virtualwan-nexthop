#vmname: branch1VM
az network bastion ssh --name az-dmz-bastion --resource-group lab-vwan-nexthop --target-ip-address 10.100.0.4 --auth-type password --username azureuser
#vmname: spoke1VM
az network bastion ssh --name az-dmz-bastion --resource-group lab-vwan-nexthop --target-ip-address 10.1.0.4 --auth-type password --username azureuser
#vmname: spoke2-linux-nva1
az network bastion ssh --name az-dmz-bastion --resource-group lab-vwan-nexthop --target-ip-address 10.2.0.36 --auth-type password --username azureuser
#vmname: spoke2-linux-nva2
az network bastion ssh --name az-dmz-bastion --resource-group lab-vwan-nexthop --target-ip-address 10.2.0.37 --auth-type password --username azureuser
#vmname: spoke3VM
az network bastion ssh --name az-dmz-bastion --resource-group lab-vwan-nexthop --target-ip-address 10.2.1.4 --auth-type password --username azureuser
#vmname: spoke4VM
az network bastion ssh --name az-dmz-bastion --resource-group lab-vwan-nexthop --target-ip-address 10.2.2.4 --auth-type password --username azureuser
