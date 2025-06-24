#!/bin/bash

neighbor1=$1
neighbor2=$2

sudo vtysh << EOVTYSH
conf t
router bgp 65002
 address-family ipv4 unicast
  no neighbor $neighbor1 route-map lbnexthop out
  no neighbor $neighbor2 route-map lbnexthop out
 exit-address-family
exit
EOVTYSH


