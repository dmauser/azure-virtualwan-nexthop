# Tcpdump command to capture traffic to/from a specific host
# Between spoke1vm and spokevm3
sudo tcpdump -n host 10.1.0.4 and 10.2.1.4
# Between branchvm1 and spokevm3
sudo tcpdump -n host 10.100.0.4 and 10.2.1.4