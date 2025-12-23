#!/bin/bash

LOG="internet_monitor.log"
INTERVAL=5
PING_TIMEOUT=3

GATEWAY=$(route -n get default | grep gateway | awk '{print $2}')

TARGETS=(
  "$GATEWAY"
  "8.8.8.8"
  "1.1.1.1"
  "9.9.9.9"
  "181.213.132.2"
  "3.163.236.182"
  "172.217.162.14"
)

while true; do
  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
  
  for TARGET in "${TARGETS[@]}"; do

    # if timeout $PING_TIMEOUT ping -c 1 -W 2 "$TARGET" > /dev/null 2>&1; then
    #   STATUS="OK"
    # else
    #   STATUS="FAIL"
    # fi

    # echo "$TIMESTAMP | $TARGET | $STATUS" >> "$LOG"


    PING_OUTPUT=$(ping -c 1 -W 2 "$TARGET" 2>/dev/null)
    PING_STATUS=$?
    if [[ $PING_STATUS -eq 0 ]]; then
      # TIME_MS=$(echo "$PING_OUTPUT" | grep -oE 'time[=<][0-9.]+' | grep -oE '[0-9.]+')
      # if [[ -z "$TIME_MS" ]]; then
      #   TIME_MS=$(echo "$PING_OUTPUT" \
      #     | awk -F'=' '/round-trip/{print $2}' \
      #     | awk -F'/' '{print $2}')
      # fi

      TIME_MS=$(echo "$PING_OUTPUT" \
      | awk -F'=' '/round-trip/{print $2}' \
      | awk -F'/' '{print $2}')
      [[ -z "$TIME_MS" ]] && TIME_MS="?"
      STATUS="OK"
    else
      TIME_MS="timeout"
      STATUS="FAIL"
    fi
    
    echo "$TIMESTAMP | $TARGET | ${TIME_MS} ms | $STATUS " >> "$LOG"
  done

  sleep $INTERVAL
done
