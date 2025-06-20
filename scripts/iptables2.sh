#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Run as root or with sudo"
  exit 1
fi

echo "Installing iptables-persistent if not already installed..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y iptables-persistent

echo "Flushing existing iptables rules..."
iptables -F
iptables -X
iptables -t nat -F
iptables -t mangle -F

echo "Setting default policies to ACCEPT..."
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

echo "Allow all loopback (localhost) traffic..."
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

echo "Enable stateful inspection (connection tracking)..."
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m conntrack --ctstate NEW -j ACCEPT

echo "Saving iptables rules for persistence..."
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

echo "Reloading persistent rules..."
netfilter-persistent reload

echo "Done. iptables with stateful inspection and allow-all policy is active and persistent."