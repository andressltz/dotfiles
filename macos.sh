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

title "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

title "Installing ZSH"
if command -v zsh >/dev/null 2>&1; then
    log "Zsh já está instalado."
else
    brew install zsh
    chsh -s $(which zsh)
fi

cp ~/.zshrc ~/.zshrc.bak
cp .zshrc ~/.zshrc

title "Configuring Homebrew on ZSH"
# echo >> ~/.zshrc
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> ~/.zshrc
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

title "Configuring macOS defaults"
# Show X apps recents in Dock
alias setRecents="defaults write com.apple.dock show-recent-count -int 4"

./common.sh

title "Installing Homebrew packages for macOS"
# brew install --cask zulu@8
# brew install --cask sapmachine11-jdk
# brew install --cask sapmachine17-jdk
