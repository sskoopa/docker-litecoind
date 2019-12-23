#!/bin/bash

set -euo pipefail

LITECOIN_DIR=/root/.litecoin
LITECOIN_CONF=${LITECOIN_DIR}/litecoin.conf

# If config doesn't exist, initialize with sane defaults for running a
# non-mining node.

if [ ! -e "${LITECOIN_CONF}" ]; then
  tee -a >${LITECOIN_CONF} <<EOF

# For documentation on the config file, see
#
# the Litecoin source:
#   https://github.com/litecoin-project/litecoin/blob/master/share/examples/litecoin.conf
# the wiki:
#   https://litecoin.info/index.php/Main_Page

# server=1 tells litecoin-Qt and litecoind to accept JSON-RPC commands
server=1

# You must set rpcuser and rpcpassword to secure the JSON-RPC api
rpcuser=${LTC_RPCUSER:-LTC}
rpcpassword=${LTC_RPCPASSWORD:-changemeplz}

# How many seconds LITECOIN will wait for a complete RPC HTTP request.
# after the HTTP connection is established.
rpcclienttimeout=${LTC_RPCCLIENTTIMEOUT:-30}

rpcallowip=${LTC_RPCALLOWIP:-::/0}

# Listen for RPC connections on this TCP port:
rpcport=${LTC_RPCPORT:-9332}

# Print to console (stdout) so that "docker logs litecoind" prints useful
# information.
printtoconsole=${LTC_PRINTTOCONSOLE:-1}

# We probably don't want a wallet.
disablewallet=${LTC_DISABLEWALLET:-1}

# Enable an on-disk txn index. Allows use of getrawtransaction for txns not in
# mempool.
txindex=${LTC_TXINDEX:-0}

# Run on the test network instead of the real litecoin network.
testnet=${LTC_TESTNET:-0}

# Set database cache size in MiB
dbcache=${LTC_DBCACHE:-512}

# ZeroMQ notification options:
zmqpubrawblock=${LTC_ZMQPUBRAWBLOCK:-tcp://0.0.0.0:29333}
zmqpubrawtx=${LTC_ZMQPUBRAWTX:-tcp://0.0.0.0:29333}
zmqpubhashtx=${LTC_ZMQPUBHASHTX:-tcp://0.0.0.0:29333}
zmqpubhashblock=${LTC_ZMQPUBHASHBLOCK:-tcp://0.0.0.0:29333}

EOF
fi

if [ $# -eq 0 ]; then
  exec litecoind -datadir=${LITECOIN_DIR} -conf=${LITECOIN_CONF}
else
  exec "$@"
fi
