#!/bin/bash

function time_total
{
    grep ch_time: | cut -d' ' -f7
}

function time_tx
{
    grep ch_time_tx: | cut -d' ' -f7
}

t=$(mktemp)
ethtool -S wlan0 > "$t"
before_total=$(cat "$t" | time_total)
before_tx=$(cat "$t" | time_tx)

dd if=/dev/zero count 1000 | nc "$1" 5000

t=$(mktemp)
ethtool -S wlan0 > "$t"
after_total=$(cat "$t" | time_total)
after_tx=$(cat "$t" | time_tx)

bc -l <<< "($after_tx - $before_tx) / ($after_total - $after_tx)"

