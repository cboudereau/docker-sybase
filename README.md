# docker-sybase

[![build](https://github.com/cboudereau/docker-sybase/workflows/publish/badge.svg)](https://github.com/cboudereau/docker-sybase/actions/workflows/publish.yml?query=event%3Arelease)
[![License:MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![docker](https://img.shields.io/docker/pulls/superbeeeeeee/docker-sybase)](https://hub.docker.com/r/superbeeeeeee/docker-sybase)


Sybase docker image for local __dev only__.

:warning: This image is not production ready and should be used for dev only

For a dev usage a licence should be used and mounted in the container.

## Run as docker container
```bash
docker run --rm -it --name sybase -e SA_PASSWORD=Sybase1234 -e DATABASE=hello -p 5000:5000 -v $(pwd)/init/:/docker-entrypoint-initdb.d/ superbeeeeeee/docker-sybase
```

## Docker compose example
- [Basic example](./examples/basic/compose.yml)
- [Full example](./.ci/compose.yml)
```yaml
services:
  database:
    image: superbeeeeeee/docker-sybase
    pull_policy: always
    environment:
      - DATABASE=hello
      - SA_PASSWORD=Sybase1234
    volumes:
      - ./init/:/docker-entrypoint-initdb.d/
    ports:
      - 5000:5000
    healthcheck:
      test: healthcheck
      interval: 5s
```

## isql demo

run the docker-compose example: [basic example](./examples/basic/)

1️⃣ Run the demo
```bash
cd examples/basic/
docker compose down --remove-orphans -v --rmi local && docker compose up
```

2️⃣ Run a basic query
```bash
. /opt/sap/SYBASE.sh && echo -e "select top 10 * from TEST_TABLE\ngo" | isql -Usa -P${SA_PASSWORD} -D${DATABASE}
```

3️⃣ Run isql
```bash
docker compose exec -it database sh
. /opt/sap/SYBASE.sh
isql -Usa
```

### show databases
```sql
sp_helpdb
go
```

### describe database
```sql
sp_helpdb TESTDB
go
```

### show tables
```sql
use TESTDB
go
sp_tables
go
```

### describe table
```sql
sp_help TEST_TABLE
go
```