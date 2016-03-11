#!/bin/bash
# configures a wireless interface

if (( $# < 2 )); then
  echo "Usage: setup.sh <iface> <ip_addr>"
  exit
fi

iface="$1"
ip_addr="$2"

set -x -e

iwconfig $iface mode ad-hoc
ifconfig $iface $ip_addr
ifconfig $iface netmask 255.255.255.0
iwconfig $iface txpower 1
iwconfig $iface rate 6M fixed

iw dev $iface ibss join mellott 5180 fixed-freq aa:bb:cc:dd:ee:ff

