#!/bin/bash

SHOW_STATUS=false

case "$1" in
  --status)
    SHOW_STATUS=true
    ;;
  --help)
    echo "Uso:"
    echo "  gitls           Lista projetos git"
    echo "  gitls --status  Inclui status clean/dirty"
    exit 0
    ;;
esac

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

if $SHOW_STATUS; then
  printf "%-40s | %-25s | %s\n" "PROJETO" "BRANCH" "STATUS"
  printf -- "--------------------------------------------------------------------------------\n"
else
  printf "%-40s | %-25s\n" "PROJETO" "BRANCH"
  printf -- "-------------------------------------------------------------------\n"
fi

find . -type d -name ".git" -prune | sort | while read gitdir; do
  repo=$(dirname "$gitdir")

  project_name=$(basename "$repo")

  branch=$(git -C "$repo" branch --show-current 2>/dev/null)

  if $SHOW_STATUS; then
    if git -C "$repo" diff --quiet && git -C "$repo" diff --cached --quiet; then
      status="${GREEN}clean${NC}"
    else
      status="${RED}dirty${NC}"
    fi

    printf "%-40s | %-25s | %b\n" \
      "$project_name" \
      "$branch" \
      "$status"
  else
    printf "%-40s | %-25s\n" \
      "$project_name" \
      "$branch"
  fi
done