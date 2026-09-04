#!/usr/bin/env bash

set -e

EMAIL="$1"
OS="$(uname -s)"

log() {
    echo "🟡 ==> $1"
}

title() {
    echo "####################################"
    echo "🟡 ==> $1"
    echo "####################################"
}

case "$OS" in
    Darwin)
        title "Configurando ambiente para $OS"
        ./macos.sh "$EMAIL"
        ;;
    Linux)
        title "Configurando ambiente para $OS"
        ./linux.sh "$EMAIL"
        ;;
    *)
        title "Sistema não suportado: $OS"
        exit 1
        ;;
esac
