# LAB: Azure Virtual WAN Next Hop IP

# Description
This lab demonstrates how to configure a Next Hop IP in Azure Virtual WAN. It includes the deployment of a Virtual WAN, Virtual Hub, and the necessary configurations to set up a Next Hop IP.

# Prerequisites
- Use [Azure CLI Bash on Linux](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux) or [Azure Cloud Shell CLI Bash](https://shell.azure.com).
- The scripts on this repo do not work in the Azure Cloud Shell PowerShell or CMD.

# Lab Network Diagram


# Deployment Steps

1. Open your Azure CLI Bash and run the following commands to deploy the lab:

```bash
wget -q -O 1deploy.sh https://raw.githubusercontent.com/dmauser/azure-virtualwan/refs/heads/main/next-hop-ip/1deploy.sh
chmod +x 1deploy.sh
./1deploy.sh
```

2. After deployment is completed, run couple validations before Next Hop IP configuration:

2.1 - Check BGP peering status from Virtual WAN Routers to the NVA instances:

2.2 - Log in to the NVA instances (accessible via Serial Console) and check the BGP peering configuration:

Example for NVA1:

```bash

```

2.3 - Check connectivity from spoke1vm and branch1vm to the spoke3vm which is behind the NVAs:

```bash
while true; do
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  RESPONSE=$(curl --max-time 5 -s 10.2.1.4)
  if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] curl succeeded: $RESPONSE"
  else
    echo "[$TIMESTAMP] curl failed or timed out"
  fi
  sleep 5
done
```

3 - Enable stateful inspection on the NVAs by running the following script:

```bash
wget -q -O 2enable-stateful-inspection.sh https://raw.githubusercontent.com/d

