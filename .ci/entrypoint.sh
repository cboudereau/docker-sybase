#!/bin/sh
set -eu

/docker-entrypoint.sh | tee /log/database.log