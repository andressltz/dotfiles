#!/bin/bash

# How to use:
# chmod +x run-npm-all.sh
# ./run-npm-all.sh          # roda "npm install" em todos os projetos
# ./run-npm-all.sh update   # roda "npm update" em todos os projetos
# ./run-npm-all.sh run build # roda "npm run build" em todos os projetos

LOG_FILE="$(pwd)/npm_all.log"

if [ -z "$1" ]; then
    echo "Uso: $0 <diretorio_base> [comando_npm]"
    echo "Exemplo: $0 ~/dev install"
    exit 1
fi

BASE_DIR="$1"
shift  # Remove first arg, base dir

if [ -z "$1" ]; then
    NPM_CMD="install"
else
    NPM_CMD="$*"
fi

> "$LOG_FILE"

for dir in "$BASE_DIR"/*; do
    if [ -d "$dir" ] && [ -f "$dir/package.json" ]; then
        echo "📦 Executando 'npm $NPM_CMD' em: $dir" | tee -a "$LOG_FILE"
        (
            cd "$dir" && npm $NPM_CMD 2>&1
        ) | tee -a "$LOG_FILE"
        echo | tee -a "$LOG_FILE"
    else
        echo "⏩ Ignorando: $dir (não é um projeto Node)" | tee -a "$LOG_FILE"
    fi
done

echo "✅ Finalizado! Log salvo em: $LOG_FILE" | tee -a "$LOG_FILE"
