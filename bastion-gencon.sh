rg=lab-vwan-nexthop

### Generate connections ###
# Get all VMs in the resource group
vms=$(az vm list -g $rg --query "[].{name:name}" -o tsv)
output_file="vmconnection.sh"
> "$output_file"  # Truncate or create the file

for vm in $vms; do
    # Get the private IP address of the VM
    privateIp=$(az vm list-ip-addresses -g $rg -n $vm --query "[0].virtualMachine.network.privateIpAddresses[0]" -o tsv)
        
    # Construct the Bastion SSH command
    echo "#vmname:" $vm | tee -a "$output_file"
    echo az network bastion ssh --name "$bastionName" --resource-group "$rg" --target-ip-address "$privateIp" --auth-type "password" --username "$username" | tee -a "$output_file"
done
