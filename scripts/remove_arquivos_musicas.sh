#!/bin/bash

# Diretório alvo (padrão: atual)
DIR="${1:-.}"

echo "Limpando diretório: $DIR"

# Remove arquivos lixo comuns
find "$DIR" -type f \( \
    -iname ".DS_Store" -o \
    -iname "Thumbs.db" -o \
    -iname "desktop.ini" -o \
    -iname "._*" \
 \) -print -delete

# Remove tudo que NÃO for música ou imagem (considerando que algumas capas de álbuns podem ser imagens)
find "$DIR" -type f ! \( \
    -iname "*.cda" -o \
    -iname "*.wma" -o \
    -iname "*.mp3" -o \
    -iname "*.m4a" -o \
    -iname "*.aac" -o \
    -iname "*.flac" -o \
    -iname "*.wav" -o \
    -iname "*.ogg" -o \
    -iname "*.opus" -o \
    -iname "*.aiff" -o \
    -iname "*.alac" -o \
    -iname "*.m3u" -o \
    -iname "*.m3u8" \
\) -print -delete

# Remove diretórios vazios (de dentro pra fora)
find "$DIR" -type d -empty -print -delete

echo "Limpeza concluída."
