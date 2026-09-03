#!/usr/bin/env bash

set -e

echo "==> Configurando ambiente comum"

install_zsh() {
    if command -v zsh >/dev/null 2>&1; then
        echo "Zsh já está instalado."
        return
    fi

    echo "Instalando Zsh..."

    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
        chsh -s $(which zsh)
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update
        sudo apt install -y zsh
        chsh -s $(which zsh)
    else
        echo "Sistema não suportado para instalação do Zsh."
        exit 1
    fi
}

install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "Oh My Zsh já está instalado."
        return
    fi

    echo "Instalando Oh My Zsh..."

    RUNZSH=no \
    CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

install_package() {
    local package="$1"

    if ! command -v "$package" >/dev/null 2>&1; then
        echo "==> Instalando $package"
        brew install "$package"
    else
        echo "==> $package já instalado"
    fi
}

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install_zsh

install_oh_my_zsh

# cd ~
# mkdir dev
# cd dev
# mkdir home

# ln -s ~/.zshrc ~/dev/home/.zshrc

cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore

# git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/F-Sy-H
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

echo
echo "==> Ambiente comum configurado."
