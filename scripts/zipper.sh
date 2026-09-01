#!/bin/bash

# Verifica se o diretório foi informado
if [ -z "$1" ]; then
    echo "Uso: $0 <diretorio>"
    exit 1
fi

DIR="$1"

# Verifica se o diretório existe
if [ ! -d "$DIR" ]; then
    echo "Erro: diretório '$DIR' não encontrado."
    exit 1
fi

# Remove a barra final, caso exista
DIR="${DIR%/}"

# Obtém o caminho absoluto do diretório pai
PAI="$(cd "$(dirname "$DIR")" && pwd)"

# Obtém apenas o nome do diretório
NOME="$(basename "$DIR")"

# Arquivo ZIP será criado ao lado da pasta
ARQUIVO="$PAI/$NOME.zip"

echo "Diretório: $DIR"
echo "Arquivo:   $ARQUIVO"
echo

zip -r "$ARQUIVO" "$DIR" \
    -x "*/__MACOSX/*" \
    -x "*/.DS_Store" \
    -x "*/._*" \
    -x "*/node_modules/*" \
    -x "*/target/*"

if [ $? -eq 0 ]; then
    echo
    echo "Compactação concluída com sucesso!"
    echo "Arquivo: $ARQUIVO"
else
    echo
    echo "Erro durante a compactação."
    exit 1
fi
