#!/usr/bin/env zsh

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
    
    title "Installing Oh My Zsh..."
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log "Oh My Zsh already installed."
    else
        RUNZSH=no \
        CHSH=no \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"        
    fi

    CUSTOM_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

    title "Installing theme for Oh My Zsh..."
    cp zsh/custom/themes/agnoster-customized.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/agnoster-customized.zsh-theme

    title "Installing plugins for Oh My Zsh..."

    title "Installing zsh-autosuggestions"
    
    if [[ -d "$CUSTOM_PATH/plugins/zsh-autosuggestions" ]]; then
        log "zsh-autosuggestions already installed."
    else
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    title "Installing F-Sy-H"
    if [[ -d "$CUSTOM_PATH/plugins/F-Sy-H" ]]; then
        log "F-Sy-H already installed."
    else
        git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/F-Sy-H
    fi 

    title "Installing zsh-completions"
    if [[ -d "$CUSTOM_PATH/plugins/zsh-completions" ]]; then
        log "zsh-completions already installed."
    else
        git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
    fi

    title "Backup and configuring .zshrc"
    if [ -f "$HOME/.zshrc" ]; then
        cp ~/.zshrc ~/.zshrc.bak
    fi
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

title "Configuring common environment..."

install_oh_my_zsh

title "Installing Fonts"
if [ -d "fonts" ]; then
    log "Fonts already installed."
    cd fonts
    git pull
    ./install.sh
    cd ..
    rm -rf fonts
else
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
fi

title "Configuring Git"

if [ -f "$HOME/.gitconfig" ]; then
    echo "📦 Arquivo .gitconfig existente encontrado. Criando backup para .gitconfig.bak..."
    cp ~/.gitconfig ~/.gitconfig.bak
else
    echo "ℹ️ Nenhum .gitconfig anterior encontrado. Instalação limpa, pulando backup."
fi

if [ -f "$HOME/.gitignore" ]; then
    echo "📦 Arquivo .gitignore existente encontrado. Criando backup para .gitignore.bak..."
    cp ~/.gitignore ~/.gitignore.bak
else
    echo "ℹ️ Nenhum .gitignore anterior encontrado. Instalação limpa, pulando backup."
fi

cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore

if [[ -z "$GIT_EMAIL" ]]; then
    # read -rp "E-mail para os commits: " GIT_EMAIL
    read -r "GIT_EMAIL?E-mail para os commits: "
fi
git config --global user.email "$GIT_EMAIL"

title "Installing NVM (Node Version Manager)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts
nvm use --lts

nvm install 6.11.2
nvm install 14.17.3
nvm install 18.19.1
nvm install 20.19.6
nvm alias default 20

title "Installing Homebrew packages"
install_brew_package kubectl
install_brew_package fastfetch

log "Common environment configured."
