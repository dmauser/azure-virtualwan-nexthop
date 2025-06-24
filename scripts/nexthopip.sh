#!/bin/bash

ip=$1
neighbor1=$2
neighbor2=$3
sudo vtysh << EOVTYSH
conf t
route-map lbnexthop permit 10
 set ip next-hop $ip
exit

router bgp 65002
 address-family ipv4 unicast
  neighbor $neighbor1 route-map lbnexthop out
  neighbor $neighbor2 route-map lbnexthop out
 exit-address-family
exit
EOVTYSH

sudo vtysh -c "write memory"
