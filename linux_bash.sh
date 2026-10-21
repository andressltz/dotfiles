#!/usr/bin/env bash

set -e

EMAIL="$1"

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

title "Installing basic dependencies"

sudo apt update
sudo apt upgrade -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
sudo apt-get install -y \
    curl \
    git \
    unzip \
    procps \
    file \
    build-essential

if [ -n "${BASH_VERSION:-}" ]; then
    echo "Executando no bash"

    title "Installing ZSH"
    if command -v zsh >/dev/null 2>&1; then
        chsh -s $(which zsh)
        log "ZSH já está instalado."
    else
        sudo apt install -y zsh
        chsh -s $(which zsh)
        title "You need restart your terminal for ZSH to take effect. Please run the script again after restarting your terminal."
        exit 0
    fi

fi
