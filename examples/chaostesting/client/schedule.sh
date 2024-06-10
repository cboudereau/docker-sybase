#!/bin/sh
. /opt/sap/SYBASE.sh

set -u

while true
do
    echo running $1
    isql -Usa -S${SERVER}:5000 -P${SA_PASSWORD} -D${DATABASE} -i $1
    echo -n "client:1|c" >/dev/udp/statsd/8125
    sleep 1
done