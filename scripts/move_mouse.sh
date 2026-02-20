#!/bin/bash

# brew install cliclick
# chmod +x move_mouse.sh

while true; do
  POS=$(cliclick p)
  X=$(echo $POS | awk -F, '{print $1}')
  Y=$(echo $POS | awk -F, '{print $2}')

  # Move 1px
  cliclick m:$((X+1)),$Y
  sleep 0.2
  cliclick m:$X,$Y

  sleep 300
done
