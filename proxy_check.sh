#!/bin/bash

while read _ _ _ PORT _ IP; do
  (PROXY=${IP}:$(echo ${PORT} | sed 's/\/tcp//')
  STATUS=$(curl --max-time 2 -s -x ${PROXY} -o /dev/null -w '%{http_code}' https://m.vk.com)
  if [ ${STATUS} -eq 200 ]; then
    echo GOOD: ${PROXY}
    echo "${PROXY}" >> good_list.txt
  else
    echo BAD: ${PROXY}
    echo "${PROXY}" >> bad_list.txt
  fi) &
done < <(tail -f /opt/proxylists.txt)
