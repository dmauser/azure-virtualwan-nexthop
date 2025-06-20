#!/bin/bash
# Commands to run over the NVAs
sudo -s
vtysh 
show running-config
show ip bgp
show ip bgp summary
show ip bgp neighbors
show ip bgp neighbors 192.168.1.69 received-routes
show ip bgp neighbors 192.168.1.69 advertised-routes
show ip bgp neighbors 192.168.1.70 received-routes
show ip bgp neighbors 192.168.1.70 advertised-routes


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


