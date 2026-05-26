#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

printf "%-40s | %-25s | %s\n" "PROJETO" "BRANCH" "STATUS"
printf -- "--------------------------------------------------------------------------------\n"

find . -type d -name ".git" -prune | sort | while read gitdir; do
  repo=$(dirname "$gitdir")

  project_name=$(basename "$repo")

  branch=$(git -C "$repo" branch --show-current 2>/dev/null)

  if git -C "$repo" diff --quiet && git -C "$repo" diff --cached --quiet; then
    status="${GREEN}clean${NC}"
  else
    status="${RED}dirty${NC}"
  fi

  printf "%-40s | %-25s | %b\n" \
    "$project_name" \
    "$branch" \
    "$status"
done
