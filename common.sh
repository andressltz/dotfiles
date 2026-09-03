#!/usr/bin/env bash

set -e

echo "==> Configurando ambiente comum"

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
    # git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/F-Sy-H
    # git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
}

install_brew_package() {
    local package="$1"

    if ! command -v "$package" >/dev/null 2>&1; then
        echo "==> Instalando $package"
        brew install "$package"
    else
        echo "==> $package já instalado"
    fi
}

install_oh_my_zsh

echo "==> Configuring Git"
cp ~/.gitconfig ~/.gitconfig.bak
cp ~/.gitignore ~/.gitignore.bak

cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore

# ln -s ~/.zshrc ~/dev/home/.zshrc

# echo "==> Installing Homebrew packages"
# install_brew_package "git"

echo
echo "==> Ambiente comum configurado."
