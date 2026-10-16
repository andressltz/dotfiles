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
sudo apt-get install -y \
    curl \
    git \
    unzip \
    procps \
    file \
    build-essential

title "Installing ZSH"
if command -v zsh >/dev/null 2>&1; then
    log "ZSH já está instalado."
else
    sudo apt update
    sudo apt install -y zsh
    chsh -s $(which zsh)
    title "You need restart your terminal for ZSH to take effect. Please run the script again after restarting your terminal."
    exit 1
fi

title "Installing Homebrew"
if command -v brew >/dev/null 2>&1; then
    log "Homebrew já está instalado."
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    title "Configuring Homebrew on ZSH"
    echo >> ~/.zshrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> ~/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

title "Installing SDKMAN"
curl -s "https://get.sdkman.io" | zsh
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

title "Installing JAVA with SDKMAN"
sdk install java 8.0.504+1-zulu
sdk install java 11.0.32.fx-zulu
sdk install java 17.0.20.fx-zulu
sdk install java 21.0.12.fx-zulu

title "Installing Maven with SDKMAN"
sdk install maven

./common.sh "$EMAIL"

title "Installing Homebrew packages for Linux"
brew install docker-engine
# if ! groups "$USER" | grep -q '\bdocker\b'; then
    # log "Adicionando $USER ao grupo docker"
    # sudo usermod -aG docker "$USER"
    # newgrp docker
# fi
