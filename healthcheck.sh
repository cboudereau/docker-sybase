#!/bin/sh
netstat -ltn | grep 5000 || exit 1

if  [[ ! -f "/.initialized" ]]; then exit 1; fi