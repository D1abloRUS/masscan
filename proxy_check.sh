#!/bin/bash

while read _ _ _ PORT _ IP; do
  (PROXY=${IP}:$(echo ${PORT} | sed 's/\/tcp//')
  STATUS=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1}' http://${PROXY})
  if [[ ${STATUS} =~ ^\{.*\}$ ]]; then
    echo GOOD: ${PROXY}
    echo "${PROXY}" >> good_list.txt
  fi) &
done < <(tail -f /opt/proxylists.txt)
