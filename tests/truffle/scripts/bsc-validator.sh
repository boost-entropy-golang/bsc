#!/usr/bin/env bash
source /scripts/utils.sh

DATA_DIR=/root/.ethereum

wait_for_host_port ${BOOTSTRAP_HOST} ${BOOTSTRAP_TCP_PORT}
BOOTSTRAP_IP=$(get_host_ip $BOOTSTRAP_HOST)
VALIDATOR_ADDR=$(cat ${DATA_DIR}/address)
HOST_IP=$(hostname -i)

echo "validator id: ${HOST_IP}"

geth --config ${DATA_DIR}/config.toml --datadir ${DATA_DIR} --netrestrict ${CLUSTER_CIDR} \
    --verbosity ${VERBOSE} \
    --bootnodes enode://${BOOTSTRAP_PUB_KEY}@${BOOTSTRAP_IP}:${BOOTSTRAP_TCP_PORT} \
    --mine -unlock ${VALIDATOR_ADDR} --miner.etherbase ${VALIDATOR_ADDR} --password /dev/null \
    --rpc.allow-unprotected-txs --history.transactions 15768000 >${DATA_DIR}/bscnode-validator.log
