#!/bin/bash

set -exuo pipefail

TAG=${1:-latest}

docker build -t sskoopa/litecoind:${TAG} .
docker login
docker push sskoopa/litecoind:${TAG}
