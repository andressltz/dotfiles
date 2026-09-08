#!/usr/bin/env bash

set -e

GIT_EMAIL="$1"
OS="$(uname -s)"

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

install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log "Oh My Zsh already installed."
        return
    fi

    title "Installing Oh My Zsh..."

    RUNZSH=no \
    CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    title "Installing theme for Oh My Zsh..."
    cp zsh/custom/themes/agnoster-customized.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/agnoster-customized.zsh-theme

    title "Installing plugins for Oh My Zsh..."

    title "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    title "Installing F-Sy-H"
    git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/F-Sy-H

    title "Installing zsh-completions"
    git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

    cp ~/.zshrc ~/.zshrc.bak
    cp .zshrc ~/.zshrc

    case "$OS" in
    Darwin)
        echo ""
        ;;
    Linux)
        echo >> ~/.zshrc
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> ~/.zshrc
        ;;
    *)
        title "Sistema não suportado: $OS"
        exit 1
        ;;
    esac
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

title "Configuring common environment"

install_oh_my_zsh

title "Installing Fonts"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

title "Configuring Git"
cp ~/.gitconfig ~/.gitconfig.bak
cp ~/.gitignore ~/.gitignore.bak

cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore

if [[ -z "$GIT_EMAIL" ]]; then
    read -rp "E-mail para os commits: " GIT_EMAIL
fi
git config --global user.email "$GIT_EMAIL"

# ln -s ~/.zshrc ~/dev/home/.zshrc

title "Installing NVM (Node Version Manager)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts
nvm use --lts

title "Installing Homebrew packages"
install_brew_package docker
install_brew_package openjdk@8
install_brew_package openjdk@11
install_brew_package openjdk@17
install_brew_package openjdk@21
install_brew_package maven

log "Common environment configured."
