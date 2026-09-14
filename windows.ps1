# Configure PowerShell execution policy (run as administrator)
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
Set-ExecutionPolicy RemoteSigned

# Configure git
git config --global core.longpaths true
git clone https://github.com/powerline/fonts.git --depth=1

# Install apps for user
winget install -e --id Kubernetes.kubectl

# Install WSL
wsl --install
