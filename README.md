# docker-sybase

[![build](https://github.com/cboudereau/docker-sybase/workflows/publish/badge.svg)](https://github.com/cboudereau/docker-sybase/actions/workflows/publish.yml?query=event%3Arelease)
[![License:MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![docker](https://img.shields.io/docker/pulls/superbeeeeeee/docker-sybase)](https://hub.docker.com/r/superbeeeeeee/docker-sybase)


Sybase docker image for local __dev only__.

:warning: This image is not production ready

## Run as docker image
```bash
docker run --rm -it --name sybase -e SA_PASSWORD=Sybase1234 -e DATABASE=hello -p 5000:5000 -v $(pwd)/init/:/docker-entrypoint-initdb.d/ superbeeeeeee/docker-sybase
```

## Docker compose example
see the [/docker-entrypoint-initdb.d/ folder example](https://github.com/cboudereau/docker-sybase/tree/main/.ci/init)
```
services:
  database:
    image: superbeeeeeee/docker-sybase
    pull_policy: always
    environment:
      - DATABASE=hello
      - SA_PASSWORD=Sybase1234
    volumes:
      - ./init/:/docker-entrypoint-initdb.d/
```