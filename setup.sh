#!/bin/bash
# configures a wireless node

# full daemonization of external command with setsid
# http://blog.n01se.net/blog-n01se-net-p-145.html
function daemonize {
    (
        # redirect stdin/stdout/stderr before setsid
        [[ -t 0 ]] && exec </dev/null
        [[ -t 1 ]] && exec >/dev/null
        [[ -t 2 ]] && exec 2>/dev/null

        # ensure cwd is not a mounted fs
        cd /

        # close unneeded fds
        eval exec {3..255}\>\&-

        # start daemon
        exec setsid "$@"
    ) &
}

# setup <iface> <ip_addr>
function setup {
    local iface="$1"
    local ip_addr="$2"

    iwconfig $iface mode ad-hoc
    ifconfig $iface $ip_addr
    ifconfig $iface netmask 255.255.255.0
    iwconfig $iface txpower 1
    iwconfig $iface rate 6M fixed

    iw dev $iface ibss join mellott 5180 fixed-freq aa:bb:cc:dd:ee:ff
}

name=$(hostname | cut -d'.' -f1)
exp=$(hostname | cut -d'.' -f2)
num=$(echo "$name" | sed -e 's|[^0-9]*0*||')

setup wlan0 "10.0.0.$num"

# start olsrd
olsrd=/users/mmellott/olsrd-0.9.0.3
make -C "$olsrd" install_all
daemonize olsrd

