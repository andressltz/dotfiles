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

install_brew_package() {
    local package="$1"

    if ! command -v "$package" >/dev/null 2>&1; then
        title "Installing $package"
        brew install "$package"
    else
        log "$package already installed"
    fi
}

title "Installing basic dependencies (ZSH, Homebrew)"

title "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

title "Installing ZSH"
if command -v zsh >/dev/null 2>&1; then
    log "ZSH já está instalado."
else
    brew install zsh
    chsh -s $(which zsh)
fi

title "Configuring Homebrew on ZSH"
# echo >> ~/.zshrc
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> ~/.zshrc
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

title "Configuring macOS defaults"
# Show X apps recents in Dock
alias setRecents="defaults write com.apple.dock show-recent-count -int 4"

./common.sh "$EMAIL"

title "Installing Homebrew packages for macOS"
brew install --cask zulu@8
brew install --cask sapmachine11-jdk
brew install --cask sapmachine17-jdk
# install_brew_package openjdk@8
# install_brew_package openjdk@11
# install_brew_package openjdk@17
install_brew_package openjdk@21
