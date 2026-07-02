#!/bin/bash

git fetch --prune

echo "Branches locais sem correspondente no origin:"
echo

branches=$(git branch -vv | awk '/: gone]/{print $1}')

if [ -z "$branches" ]; then
    echo "Nenhuma branch encontrada."
    exit 0
fi

echo "$branches"

echo
read -p "Deseja remover essas branches? (s/N) " resp

if [[ "$resp" =~ ^[Ss]$ ]]; then
    echo "$branches" | xargs -r git branch -D
    echo "Concluído."
else
    echo "Cancelado."
fi
