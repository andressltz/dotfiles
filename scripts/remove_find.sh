#!/bin/bash

PATTERNS="remove_find_patterns.txt"
OUTPUT="remove_files_to_review.txt"

ARGS=()

while IFS= read -r pattern || [ -n "$pattern" ]; do
    [[ -z "$pattern" || "$pattern" =~ ^# ]] && continue

    if ((${#ARGS[@]})); then
        ARGS+=(-o)
    fi

    ARGS+=(-iname "*${pattern}*")
done < "$PATTERNS"

sudo find \
    /Applications \
    /Library \
    /Users \
    /etc \
    /private \
    /opt \
    /usr/local \
    \( "${ARGS[@]}" \) \
    -print 2>/dev/null > "$OUTPUT"

echo "Resultado salvo em: $OUTPUT"