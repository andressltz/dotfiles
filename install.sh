#!/usr/bin/env bash

set -e

OS="$(uname -s)"

case "$OS" in
    Darwin)
        echo "==> Configurando ambiente para $OS"
        ./macos.sh
        ;;
    Linux)
        echo "==> Configurando ambiente para $OS"
        ./linux.sh
        ;;
    *)
        echo "Sistema não suportado: $OS"
        exit 1
        ;;
esac
