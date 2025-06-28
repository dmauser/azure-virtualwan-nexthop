#t Troubleshooting script for checking connectivity and capturing traffic
# Tcpdump command to capture traffic to/from a specific host
# Between spoke1vm and spokevm3
sudo tcpdump -n host 10.1.0.4 and 10.2.1.4
# Between branchvm1 and spokevm3
sudo tcpdump -n host 10.100.0.4 and 10.2.1.4


# restart frr
sudo systemctl restart frr
# stop frr
sudo systemctl stop frr

# Tshark to show traffic symmetry 
sudo tshark -Y 'http.request or http.response' -f 'host 10.2.1.4 and tcp port 80' -T fields -e ip.src -e tcp.srcport -e ip.dst -e tcp.dstport


#!/bin/bash

# Set your desired region and VM size
REGION="eastus2"
VM_SIZE="Standard_DS1_v2"

# Check if the VM size is available in the region
echo "Checking availability of $VM_SIZE in $REGION..."
AVAILABLE=$(az vm list-skus --location "$REGION" --size "$VM_SIZE" --query "[?name=='$VM_SIZE'] | length(@)" -o tsv 2>/dev/null)

if [[ "$AVAILABLE" -eq 0 || -z "$AVAILABLE" ]]; then
    echo "❌ VM size $VM_SIZE is NOT available in $REGION. Exiting."
    break
else
    echo "✅ VM size $VM_SIZE is available in $REGION."
fi

az vm list-skus --location centralus --size Standard_D --all --output table

