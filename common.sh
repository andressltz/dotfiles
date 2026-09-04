#!/usr/bin/env bash

set -e

echo "==> Configuring common environment"

install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "Oh My Zsh already installed."
        return
    fi

    echo "==> Installing Oh My Zsh..."

    RUNZSH=no \
    CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo "==> Installing plugins for Oh My Zsh..."
    
    echo "==> Installing zsh-autosuggestions"
    # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/dev/andressltz/dotfiles/zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    echo "==> Installing F-Sy-H"
    # git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-~/dev/andressltz/dotfiles/zsh/custom}/plugins/F-Sy-H
    git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/F-Sy-H

    echo "==> Installing zsh-completions"
    # git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/dev/andressltz/dotfiles/zsh/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
}

install_brew_package() {
    local package="$1"

    if ! command -v "$package" >/dev/null 2>&1; then
        echo "==> Installing $package"
        brew install "$package"
    else
        echo "==> $package already installed"
    fi
}

install_oh_my_zsh

echo "==> Configuring Git"
cp ~/.gitconfig ~/.gitconfig.bak
cp ~/.gitignore ~/.gitignore.bak

cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore

read -rp "E-mail para os commits: " GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

# ln -s ~/.zshrc ~/dev/home/.zshrc

echo "==> Installing NVM (Node Version Manager)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install --lts
nvm use --lts
nvm default --lts

echo
echo "==> Common environment configured."
