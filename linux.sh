#!/usr/bin/env bash

set -e

log() {
    echo "🟡 ==> $1"
}

title() {
    echo "####################################"
    echo "🟡 ==> $1"
    echo "####################################"
}

title "Installing basic dependencies (ZSH, Homebrew)"

sudo apt update
sudo apt install -y \
    curl \
    git \
    zsh \
    unzip \
    build-essential

title "Installing ZSH"
if command -v zsh >/dev/null 2>&1; then
    log "Zsh já está instalado."
else
    sudo apt update
    sudo apt install -y zsh
    chsh -s $(which zsh)
fi

title "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cp ~/.zshrc ~/.zshrc.bak
cp .zshrc ~/.zshrc

title "Configuring Homebrew on ZSH"
echo >> ~/.zshrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> ~/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

./common.sh

title "Installing Homebrew packages for Linux"
brew install docker-engine
