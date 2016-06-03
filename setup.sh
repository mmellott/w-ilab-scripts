#!/bin/bash
# configures a wireless node

set -e

# source my functions
. /users/mmellott/w-ilab-scripts/functions

# install atlas
#copy_modules

# config wireless iface
mesh "$(get_ip_addr)"

# start iperf daemon
iperf -D -s

