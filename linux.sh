#!/usr/bin/env bash

set -e

echo "==> Installing basic dependencies (ZSH, Homebrew)"

sudo apt update
sudo apt install -y \
    curl \
    git \
    zsh \
    unzip \
    build-essential

echo "==> Installing ZSH"
if command -v zsh >/dev/null 2>&1; then
    echo "Zsh já está instalado."
else
    sudo apt update
    sudo apt install -y zsh
    chsh -s $(which zsh)
fi

echo "==> Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cp ~/.zshrc ~/.zshrc.bak
cp .zshrc ~/.zshrc

echo "==> Configuring Homebrew on ZSH"
echo >> ~/.zshrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> ~/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

./common.sh

echo "==> Installing Homebrew packages for Linux"
brew install docker-engine
brew install openjdk@8
# brew install openjdk@11
# brew install openjdk@17
