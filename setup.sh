#!/bin/sh
export GETH_VERSION=release-1.9
export CURRENT_UID=$(id -u):$(id -g)

# pull docker image in advance
#docker-compose -f docker-init.yml pull

# make sure "datadir" is exist as writable directory
mkdir -p "datadir"
docker-compose -f docker-init.yml run make-accounts

COINBASE_ACCT=`find datadir/keystore -mindepth 1 -print -quit \
	| sed -r "s/.*Z--([0-9a-z])/\1/" `
echo "coinbase account: $COINBASE_ACCT"

sed -e "s/ADDRESS/$COINBASE_ACCT/" init-scripts/genesis-template.json > datadir/genesis.json

# init with genesis.json
docker-compose -f docker-init.yml run init-chain

