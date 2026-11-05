#!/usr/bin/env bash
set -e

EMAIL="$1"
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

title "Verifying SSH keys..."
SSH_KEY_PATH="$HOME/.ssh/id_rsa"

if [ -d "$HOME/.ssh" ]; then
    log "Directory .ssh already exists."
else
    mkdir -p "$HOME/.ssh"
fi

if [ ! -f "$SSH_KEY_PATH" ]; then
    log "🔑 SSH key not found. Generating a new one..."
    # ssh-keygen -t rsa -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""
    ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    log "✅ SSH key generated successfully!"
else
    log "✅ SSH key already exists at $SSH_KEY_PATH. Skipping creation."
fi

case "$OS" in
    Darwin)
        title "Configuring environment for $OS"
        ./macos.sh "$EMAIL"
        ;;
    Linux)
        title "Configuring environment for $OS"

        if ! command -v zsh >/dev/null 2>&1; then
            ./linux_bash.sh "$EMAIL"
            log "ZSH already installed. Please open a new session and run the installer again."
            exit 0
        fi

        exec zsh ./linux_zsh.sh $EMAIL
        ;;
    *)
        title "Unsupported system: $OS"
        exit 1
        ;;
esac
