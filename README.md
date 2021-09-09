# yatebts-docker [![CI](https://github.com/c1assik/yatebts-docker/actions/workflows/blank.yml/badge.svg)](https://github.com/c1assik/yatebts-docker/actions/workflows/blank.yml)

## Building
```sh
https://github.com/c1assik/yatebts-docker.git
cd yatebts-docker
docker build -t yatebts:latest .
```
## Running
```sh
docker run -i -t -p 8008:8008 yatebts bash
yate -v
```
