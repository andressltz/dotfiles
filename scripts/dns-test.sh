#!/bin/bash

LOG="dns_monitor.log"
INTERVAL=5
PING_TIMEOUT=3

while true; do
  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
  
  echo "🎯 $TIMESTAMP | Testing G1 with Claro:" >> $LOG
  nslookup g1.globo.com 181.213.132.2 >> $LOG

  echo "🎯 $TIMESTAMP | Testing Tecnoblog with Claro:" >> $LOG
  nslookup tecnoblog.net 181.213.132.2 >> $LOG

  echo "🎯 $TIMESTAMP | Testing G1 with Google:" >> $LOG
  nslookup g1.globo.com 8.8.8.8 >> $LOG

  echo "🎯 $TIMESTAMP | Testing Tecnoblog with Google:" >> $LOG
  nslookup tecnoblog.net 8.8.8.8 >> $LOG

  echo "🎯 $TIMESTAMP | Testing G1 with CloudFlare:" >> $LOG
  nslookup g1.globo.com 1.1.1.1 >> $LOG

  echo "🎯 $TIMESTAMP | Testing Tecnoblog with CloudFlare:" >> $LOG
  nslookup tecnoblog.net 1.1.1.1 >> $LOG

  echo "🎯 $TIMESTAMP | Testing G1 with Quad9:" >> $LOG
  nslookup g1.globo.com 9.9.9.9 >> $LOG

  echo "🎯 $TIMESTAMP | Testing Tecnoblog with Quad9:" >> $LOG
  nslookup tecnoblog.net 9.9.9.9 >> $LOG
    
  sleep $INTERVAL
done
