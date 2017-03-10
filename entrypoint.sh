#!/bin/sh
if [ $# -eq 0 ]; then
  cat /dev/null > scan.txt
  masscan ${RANGE} \
    -p${PORTS} \
    --open-only \
    $(if [ -n "${ADAPTER_IP}" ]; then echo "--adapter-ip ${ADAPTER_IP}"; fi) \
    --wait 2 \
    $(if [ -n "${SHARDS}" ]; then echo "--shard ${SHARDS}"; fi) \
    --excludefile /exclude.conf \
    $(if [ -n "${BANNERS}" ]; then echo "--banners"; fi) \
    --rate ${RATE} \
    >> proxylists.txt
else
  exec "$@"
fi
