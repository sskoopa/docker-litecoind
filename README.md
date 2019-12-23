
# docker-litecoind

[![Docker Stars](https://img.shields.io/docker/stars/sskoopa/litecoind.svg)](https://hub.docker.com/r/sskoopa/litecoind/)
[![Docker Pulls](https://img.shields.io/docker/pulls/sskoopa/litecoind.svg)](https://hub.docker.com/r/sskoopa/litecoind/)

A Docker configuration with sane defaults for running a fully-validating
litecoin node, based on [Alpine Linux](https://alpinelinux.org/).

## Quick start

Requires that [Docker be installed](https://docs.docker.com/install/) on the host machine.

```bash
# Create some directory where your litecoin data will be stored.
$ mkdir /f/zdata/ltc

$ docker run --name litecoind --restart unless-stopped -d \
   --env 'LTC_RPCUSER=foo' \
   --env 'LTC_RPCPASSWORD=password' \
   --env 'LTC_TXINDEX=1' \
   --volume /f/zdata/LTC:/root/.litecoin \
   -p 127.0.0.1:9332:9332 \
   --publish 9333:9333 \
   sskoopa/litecoind

$ docker logs -f litecoind
[ ... ]
```


## Configuration

A custom `litecoin.conf` file can be placed in the mounted data directory.
Otherwise, a default `litecoin.conf` file will be automatically generated based
on environment variables passed to the container:

| name | default |
| ---- | ------- |
| LTC_RPCUSER | LTC |
| LTC_RPCPASSWORD | changemeplz |
| LTC_RPCPORT | 9332 |
| LTC_RPCALLOWIP | ::/0 |
| LTC_RPCCLIENTTIMEOUT | 30 |
| LTC_DISABLEWALLET | 1 |
| LTC_TXINDEX | 0 |
| LTC_TESTNET | 0 |
| LTC_DBCACHE | 0 |
| LTC_ZMQPUBHASHTX | tcp://0.0.0.0:29333 |
| LTC_ZMQPUBHASHBLOCK | tcp://0.0.0.0:29333 |
| LTC_ZMQPUBRAWTX | tcp://0.0.0.0:29333 |
| LTC_ZMQPUBRAWBLOCK | tcp://0.0.0.0:29333 |
