#!/usr/bin/env bash

FILES=("$@")

cat ${FILES[@]} | jq -R 'split(",")' | jq -s 'group_by(.[0]) | map({"key": .[0][0], value: {"cyclesPerTest": (map({"key": .[1], "value": .[2]}) | from_entries), "Average clock cycles": (. | map(.[2] | tonumber) | add/length)}}) | from_entries'
