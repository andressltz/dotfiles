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

# echo "Verificando chaves SSH..."
# SSH_KEY_PATH="$HOME/.ssh/id_rsa"

# if [ ! -f "$SSH_KEY_PATH" ]; then
#     echo "🔑 Chave SSH não encontrada. Gerando uma nova..."
#     ssh-keygen -t rsa -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""
#     echo "✅ Chave SSH gerada com sucesso!"
# else
#     echo "✅ Chave SSH já existe em $SSH_KEY_PATH. Pulando criação."
# fi

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
