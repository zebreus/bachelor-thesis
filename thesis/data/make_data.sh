#!/usr/bin/env bash

INPUT_FILE="$1"
TARGET_DIR="$2"

function to_csv() {
    jq -r '(.[0] | keys_unsorted) as $keys | $keys, map([.[ $keys[] ]])[] | @csv'
}

# Make data for minmax
cat $INPUT_FILE |
    jq 'to_entries | map(.value) | map(select(.Function == "minmax")) | map(del( .cyclesPerTest )) ' |
    to_csv >$TARGET_DIR/minmax_overview.csv

# Make data for keccak
cat $INPUT_FILE |
    jq 'to_entries | map(.value) | map(select(.Function == "keccak")) | map(del( .cyclesPerTest )) ' |
    to_csv >$TARGET_DIR/keccak_overview.csv

# Make data for md5
cat $INPUT_FILE |
    jq 'to_entries | map(.value) | map(select(.Function == "md5")) | map(del( .cyclesPerTest )) ' |
    to_csv >$TARGET_DIR/md5_overview.csv

# Make data for minmax
cat $INPUT_FILE |
    jq 'to_entries | map(.value) | map(select(.Function == "minmax")) | map(.id as $id | .cyclesPerTest | to_entries | map(select(.key | test("length_.*")) | {"num_inputs": (.key | sub("length_";"") | tonumber), "cycles": (.value | tonumber), "id": $id})) | flatten' |
    to_csv >$TARGET_DIR/minmax_detailed_cycles.csv
