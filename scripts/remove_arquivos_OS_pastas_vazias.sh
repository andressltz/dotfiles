#!/bin/bash

# Diretório alvo (padrão: atual)
DIR="${1:-.}"

echo "Limpando diretório: $DIR"

# Remove arquivos lixo comuns
find "$DIR" -type f \( \
    -iname ".DS_Store" -o \
    -iname "Thumbs.db" -o \
    -iname "photothumb.db" -o \
    -iname "desktop.ini" -o \
    -iname "._*" \
\) -print -delete

# Remove diretórios node_modules e target
find "$DIR" -type d \( \
    -name "node_modules" -o \
    -name "target" \
    -name "__MACOSX" \
\) -prune -print -exec rm -rf {} +

# Remove diretórios vazios (de dentro pra fora)
find "$DIR" -type d -empty -print -delete

echo "Limpeza concluída."
