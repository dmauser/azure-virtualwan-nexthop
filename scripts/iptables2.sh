#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Run as root or with sudo"
  exit 1
fi

echo "Flushing existing iptables rules..."
iptables -F
iptables -X
iptables -t nat -F
iptables -t mangle -F

echo "Setting default policies to ACCEPT..."
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

echo "Allow all loopback (localhost) traffic"
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

echo "Enable stateful inspection (connection tracking)"
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

# Optional: allow new incoming connections too (still tracked)
iptables -A INPUT -m conntrack --ctstate NEW -j ACCEPT

echo "Saving iptables rules..."
# Use iptables-persistent if installed
if command -v netfilter-persistent &> /dev/null; then
  netfilter-persistent save
elif command -v iptables-save &> /dev/null; then
  iptables-save > /etc/iptables/rules.v4
else
  echo "Warning: iptables-save not found, rules won't persist after reboot."
fi

echo "Done. Stateful iptables with allow-all policy is now active."