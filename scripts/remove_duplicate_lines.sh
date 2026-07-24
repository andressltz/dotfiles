#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Use: $0 <file>"
    exit 1
fi

FILE="$1"
NEW_FILE="${FILE}_without_duplicate.txt"

awk '!seen[$0]++' "$FILE" > "$NEW_FILE"
echo "New file: $NEW_FILE"
