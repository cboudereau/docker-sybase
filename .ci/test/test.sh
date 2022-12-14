#!/bin/sh
set -eu

. wait-for-file.sh 

waitForFile /log/done;

echo Test database create assertion && grep -e "Database 'TESTDB' is now online" /log/database.log;

echo Test database 0-hello.sh assertion && \
    grep -e "running /docker-entrypoint-initdb.d/0-hello.sh" /log/database.log && \
    grep -e "hello world" /log/database.log;

echo Test database 1-table.sql init file assertion && grep -e "running /docker-entrypoint-initdb.d/1-table.sql" /log/database.log;

echo Test database 2-data.sql.gz init file assertion && grep -e "running /docker-entrypoint-initdb.d/2-data.sql.gz" /log/database.log;
    
echo Test database should_be_ignored.txt ignored file assertion && grep -e "ignoring /docker-entrypoint-initdb.d/4-should_be_ignored.txt" /log/database.log;
     
echo Test Select assertions && grep -e "IDROW                 TEST_FIELD1" /log/database.log && \
                               grep -e "--------------------- -----------" /log/database.log && \
                               grep -e "                    1 1" /log/database.log;