#!/bin/bash

set -x

home=/users/fabrizio

#netdir="net-origin"
netdir="net-atlas"
ath_dir="ath"
driverdir="drivers/net/wireless/${ath_dir}/ath9k/"
driverdir2="drivers/net/wireless/${ath_dir}/"

#netdir="net-test"
cp $home/atlas/kernel-3.8.0-atlas/${netdir}/wireless/cfg80211.ko /lib/modules/3.8.0-37-generic/kernel/net/wireless/
cp $home/atlas/kernel-3.8.0-atlas/${netdir}/mac80211/mac80211.ko /lib/modules/3.8.0-37-generic/kernel/net/mac80211/
cp $home/atlas/kernel-3.8.0-atlas/${driverdir}/*.ko /lib/modules/3.8.0-37-generic/kernel/drivers/net/wireless/ath/ath9k/
cp $home/atlas/kernel-3.8.0-atlas/${driverdir2}/ath.ko /lib/modules/3.8.0-37-generic/kernel/drivers/net/wireless/ath/

rmmod ath9k ath9k_common ath9k_hw ath mac80211 cfg80211
modprobe ath9k

