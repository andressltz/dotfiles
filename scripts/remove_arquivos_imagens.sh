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

# Remove tudo que NÃO for imagem
find "$DIR" -type f ! \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.gif" -o \
    -iname "*.webp" -o \
    -iname "*.bmp" -o \
    -iname "*.tiff" -o \
    -iname "*.wlmp" -o \
    -iname "*.mp4" -o \
    -iname "*.mov" -o \
    -iname "*.avi" -o \
    -iname "*.m4a" -o \
    -iname "*.wmv" -o \
    -iname "*.pdf" -o \
    -iname "*.pptx" -o \
    -iname "*.mpg" -o \
    -iname "*.svg" \
\) -print -delete

# Remove diretórios vazios (de dentro pra fora)
find "$DIR" -type d -empty -print -delete

echo "Limpeza concluída."
