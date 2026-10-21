#!/usr/bin/env bash
set -e

EMAIL="$1"
OS="$(uname -s)"

log() {
    echo ""
    echo "🔴 ==> $1 🔴 <=="
    echo ""
}

title() {
    echo ""
    echo "####################################"
    echo "🟡 ==> $1"
    echo "####################################"
    echo ""
}

title "Verificando chaves SSH..."
SSH_KEY_PATH="$HOME/.ssh/id_rsa"

if [ -d "$HOME/.ssh" ]; then
    log "Directory .ssh already exists."
else
    mkdir -p "$HOME/.ssh"
fi

if [ ! -f "$SSH_KEY_PATH" ]; then
    log "🔑 Chave SSH não encontrada. Gerando uma nova..."
    # ssh-keygen -t rsa -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""
    ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    log "✅ Chave SSH gerada com sucesso!"
else
    log "✅ Chave SSH já existe em $SSH_KEY_PATH. Pulando criação."
fi

case "$OS" in
    Darwin)
        title "Configurando ambiente para $OS"
        ./macos.sh "$EMAIL"
        ;;
    Linux)
        title "Configurando ambiente para $OS"

        if ! command -v zsh >/dev/null 2>&1; then
            ./linux_bash.sh "$EMAIL"
            log "Zsh instalado. Abra uma nova sessão e execute o instalador novamente."
            exit 0
        fi

        exec zsh ./linux_zsh.sh $EMAIL
        ;;
    *)
        title "Sistema não suportado: $OS"
        exit 1
        ;;
esac
