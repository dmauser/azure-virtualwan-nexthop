#!/bin/bash
#Parameters 
rg=lab-vwan-nexthop
hub1name=hub1 
bastionName="dmz-bastion"

# Variables
region1=$(az network vhub show -n $hub1name -g $rg --query location -o tsv)

start=`date +%s`
echo "Script started at $(date)"

### Create DMZ vNet
# Create a new virtual network for the Bastion host
echo "Creating DMZ vNet..."
az network vnet create --name dmz-vnet --resource-group $rg --location $region1 --address-prefixes 10.10.0.0/24 --subnet-name AzureBastionSubnet --subnet-prefix 10.10.0.0/26 -o none

# Connect the DMZ vNet to the Virtual WAN Hub1
echo "Connecting DMZ vNet to Virtual WAN Hub1..."
az network vhub connection create --name dmz-vnet-conn -g $rg --remote-vnet dmz-vnet --vhub-name $hub1name --no-wait

### Deploy Bastion ###
# Create a public IP for the Bastion host
az network public-ip create --name $bastionName-pip --resource-group $rg --location $region1 --sku Standard --allocation-method Static -o none --only-show-errors
# Deploy bastion in the dmz-vnet
az network bastion create --location $region1 --name $bastionName --resource-group $rg --vnet-name dmz-vnet --public-ip-address $bastionName-pip --sku Standard --enable-tunneling true --enable-ip-connect true -o none &>/dev/null &

# Check if Bastion is deployed
sleep 5
while true; do
    status=$(az network bastion show --name $bastionName --resource-group $rg --query provisioningState -o tsv)
    if [ "$status" == "Succeeded" ]; then
        echo "Bastion deployed successfully."
        break
    else
        echo $status "- Waiting for Bastion deployment..."
        sleep 10
    fi
done
echo Deployment has finished
# Add script ending time but hours, minutes and seconds
end=`date +%s`
runtime=$((end-start))
echo "Script finished at $(date)"
echo "Total script execution time: $(($runtime / 3600)) hours $((($runtime / 60) % 60)) minutes and $(($runtime % 60)) seconds."
