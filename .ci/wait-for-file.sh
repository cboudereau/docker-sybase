#!/bin/sh
f=$1
while  [[ ! -f "$f" ]]
do
    echo "waiting $f"
    sleep 1
done
cat $f
