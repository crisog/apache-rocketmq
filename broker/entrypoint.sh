#!/usr/bin/env sh
set -e

mkdir -p /home/rocketmq/store /home/rocketmq/logs || true
chown -R 3000:3000 /home/rocketmq 2>/dev/null || true

: "${ROCKETMQ_HOME:=/home/rocketmq/rocketmq-5.3.2}"

if [ "$#" -eq 0 ]; then
  if [ -n "${ENABLE_PROXY:-}" ]; then
    set -- "$ROCKETMQ_HOME/bin/mqbroker" --enable-proxy -c "$ROCKETMQ_HOME/conf/broker.conf"
  else
    set -- "$ROCKETMQ_HOME/bin/mqbroker" -c "$ROCKETMQ_HOME/conf/broker.conf"
  fi
fi

exec gosu 3000:3000 "$@"
