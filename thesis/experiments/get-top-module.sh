#!/usr/bin/env bash

NAME=`basename $1`

[[ $NAME = min_max* ]] && echo "min_max" && exit 0
[[ $NAME = minmax* ]] && echo "min_max" && exit 0
[[ $NAME = md5* ]] && echo "md5" && exit 0
[[ $NAME = keccak* ]] && echo "keccak" && exit 0

echo failed to get top module name for $NAME
exit 1