#!/bin/sh
. /opt/sap/SYBASE.sh

set -u

while true
do
    echo running $1
    isql -Usa -S${SERVER}:5000 -P${SA_PASSWORD} -D${DATABASE} -i $1
    sleep 1
done