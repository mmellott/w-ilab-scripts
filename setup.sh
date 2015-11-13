#!/bin/bash

[[ -z $1 ]] && echo "Usage: setup.sh <ip addr>" && exit

set -x -e

iwconfig wlan0 mode ad-hoc
ifconfig wlan0 $ip_addr up
iwconfig wlan0 txpower 1
iwconfig wlan0 rate 6M fixed

iw dev wlan0 ibss join mellott 5180 fixed-freq aa:bb:cc:dd:ee:ff

