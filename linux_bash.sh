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

title "Updating system..."

sudo apt update
sudo apt upgrade -y

title "Installing basic dependencies... [1/2]"
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

title "Installing basic dependencies... [2/2]"
sudo apt-get install -y \
    curl \
    git \
    unzip \
    procps \
    file \
    htop \
    build-essential

if [ -n "${BASH_VERSION:-}" ]; then
    log "Executing in bash"

    title "Installing ZSH"
    if command -v zsh >/dev/null 2>&1; then
        chsh -s $(which zsh)
        log "ZSH already installed."
    else
        sudo apt install -y zsh
        chsh -s $(which zsh)
        title "You need restart your terminal for ZSH to take effect. Please run the script again after restarting your terminal."
        exit 0
    fi

fi
