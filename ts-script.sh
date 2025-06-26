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
