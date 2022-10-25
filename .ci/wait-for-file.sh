#!/bin/sh
f=$1
if  [[ ! -f "$f" ]]; then
    sleep 1
else
    cat $f
fi
