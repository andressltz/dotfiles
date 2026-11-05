#!/usr/bin/env zsh

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

log "Executing in zsh"

title "Installing Homebrew"
if command -v brew >/dev/null 2>&1; then
    log "Homebrew already installed."
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    title "Configuring Homebrew on ZSH"
    echo >> ~/.zshrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> ~/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

title "Installing Docker"

if command -v docker >/dev/null 2>&1; then
    log "Docker already installed."
else
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh

    # curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    # echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/nul
    # sudo apt update
    # apt-cache policy docker-ce
    # sudo apt install docker-ce docker-ce-cli containerd.io -y
fi

if getent group docker >/dev/null; then
    log "The docker group already exists."
else
    sudo groupadd docker
fi

if id -nG "$USER" | tr ' ' '\n' | grep -qx docker; then
    log "$USER already belongs to the docker group."
else
    sudo usermod -aG docker "$USER"
    log "$USER has been added to the docker group. Please close and reopen your session to apply the changes."
fi

if ! groups "$USER" | grep -q '\bdocker\b'; then
    log "Adding $USER to the docker group"
    sudo usermod -aG docker "$USER"
fi

sudo systemctl enable docker
sudo docker --version

title "Installing SDKMAN"
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    log "SDKMAN already installed."
else
    title "Installing SDKMAN"
    curl -s "https://get.sdkman.io" | zsh
fi

source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

title "Installing JAVA with SDKMAN"
sdk install java 8.0.512.0+8-zulu
sdk install java 11.0.33.0+9-zulu
sdk install java 17.0.21.0+9-zulu
sdk install java 21.0.13.0+9-zulu

title "Installing Maven with SDKMAN"
sdk install maven

./common.sh "$EMAIL"
