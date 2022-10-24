# docker-sybase

Sybase docker image for local __dev only__.

:warning: This image is not production ready

## Run as docker image
```bash
docker run --rm -it --name sybase -e SA_PASSWORD=Sybase1234 -e DATABASE=hello superbeeeeeee/sybase
```

## Docker compose example
```
services:
  database:
    image: superbeeeeeee/sybase
    environment:
      - DATABASE=hello
      - SA_PASSWORD=Sybase1234
    volumes:
      - ./init/:/docker-entrypoint-initdb.d/
```