#!/usr/bin/env bash

FILES=("$@")

function strip_report() {
    echo "{"

    COMMA=""
    for file in "${FILES[@]}"; do
        CASE_NAME=$(basename $file | sed 's/-report\.json//')
        echo $COMMA "\"$CASE_NAME\": "
        COMMA=","
        cat $file | jq '{
    "Logic blocks": .utilization.TRELLIS_COMB.used,
    "Flip-flops": .utilization.TRELLIS_FF.used,
    "RAM blocks": .utilization.TRELLIS_RAMW.used,
    "trueDualPortBlockRam": .utilization.DP16KD.used,
    "Multipliers": .utilization.MULT18X18D.used,
    "otherBlocks": .utilization | del( .TRELLIS_COMB, .TRELLIS_FF, .TRELLIS_RAMW, .TRELLIS_IO, .DCCA, .MULT18X18D, .DP16KD ) | map(.used) | add ,
    "Area": .utilization | [ .TRELLIS_COMB, .TRELLIS_FF, .TRELLIS_RAMW, .MULT18X18D, .DP16KD ] | map(.used) | add ,
    "Maximum frequency (MHz)": .fmax[].achieved,
    }'
    done

    echo "}"
}

strip_report | jq
