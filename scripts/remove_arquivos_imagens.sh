#!/bin/bash

# Diretório alvo (padrão: atual)
DIR="${1:-.}"

echo "Limpando diretório: $DIR"

# Extensões de imagens permitidas
EXTENSIONS="jpg jpeg png gif webp bmp tiff svg"

# Remove arquivos lixo comuns
find "$DIR" -type f \( \
    -iname ".DS_Store" -o \
    -iname "Thumbs.db" -o \
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
    -iname "*.svg" \
\) -print -delete

echo "Limpeza concluída."
