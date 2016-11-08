#!/bin/bash

function time_total
{
    grep ch_time: | cut -d' ' -f7
}

function time_tx
{
    grep ch_time_tx: | cut -d' ' -f7
}

before=$(mktemp)
after=$(mktemp)

ethtool -S wlan0 > "$before"
dd if=/dev/zero count=1000 | nc "$1" 5000
ethtool -S wlan0 > "$after"

before_total=$(cat "$before" | time_total)
before_tx=$(cat "$before" | time_tx)
after_total=$(cat "$after" | time_total)
after_tx=$(cat "$after" | time_tx)

echo "($after_tx - $before_tx) / ($after_total - $after_tx)"
bc -l <<< "($after_tx - $before_tx) / ($after_total - $after_tx)"

