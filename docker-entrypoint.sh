#!/bin/sh
. /opt/sap/SYBASE.sh

set -eum

ISQL="isql -Usa -P${SA_PASSWORD}"

run_init_files () {
  local f
  for f; do
		case "$f" in
			*.sh)
				if [ -x "$f" ]; then
					echo "running $f"
					"$f"
				else
					echo "sourcing $f"
					. "$f"
				fi
				;;
      *.sql)    echo "running $f"; ${ISQL} -i $f ;;
      *.sql.gz) echo "running $f"; gunzip -c "$f" | ${ISQL} ;;
      *)        echo "ignoring $f" ;;
    esac
  done
}

echo "starting sybase..."
${SYBASE}/${SYBASE_ASE}/install/RUN_SYBASE &

while ! netstat -ltn | grep -c 5000; do   
  sleep 0.1
done
echo "sybase started"

if  [[ ! -f "/.initialized" ]]; then
    echo -e sp_password 'Sybase123',\'${SA_PASSWORD}\' ,sa\\ngo | isql -Usa -PSybase123
    echo -e "CREATE DATABASE ${DATABASE}\ngo" | ${ISQL} # Database '${DATABASE}' is now online.
    run_init_files /docker-entrypoint-initdb.d/*
    echo "ok" > /.initialized
fi

fg