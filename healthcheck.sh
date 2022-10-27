#!/bin/sh
netstat -ltn | grep 5000 || exit 1