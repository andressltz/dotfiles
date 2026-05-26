#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

printf "%-40s | %-25s | %s\n" "PROJETO" "BRANCH" "STATUS"
printf -- "--------------------------------------------------------------------------------\n"

find . -type d -name ".git" | while read gitdir; do
  repo=$(dirname "$gitdir")
  branch=$(git -C "$repo" branch --show-current 2>/dev/null)

  if [[ -n $(git -C "$repo" status --porcelain 2>/dev/null) ]]; then
    status="${RED}dirty${NC}"
  else
    status="${GREEN}clean${NC}"
  fi

  printf "%-40s | %-25s | %b\n" \
    "$(basename "$repo")" \
    "$branch" \
    "$status"
done
