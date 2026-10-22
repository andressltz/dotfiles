# Configure PowerShell execution policy (run as administrator)
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
Set-ExecutionPolicy RemoteSigned

# Install apps for user
winget install -e --id Kubernetes.kubectl
winget install Microsoft.Coreutils
winget install Microsoft.PowerToys -s winget
winget install -e --id Ditto.Ditto
winget install fastfetch
# https://git-scm.com/install/windows
# https://conemu.github.io/en/Downloads.html
# https://winmerge.org/downloads/?lang=en
# https://www.logitech.com/pt-br/software/logi-options-plus#blade-quick-links
# https://www.jetbrains.com/idea/download/
# https://notepad-plus-plus.org/downloads/
# https://www.postman.com/downloads/
# https://dbeaver.io/download/

# Configure git
git config --global core.longpaths true
git clone https://github.com/powerline/fonts.git --depth=1

# Install WSL
wsl --install
