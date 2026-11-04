eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

#WSL
# Clean memory on Windows because WSL2 has a memory leak problem
alias limpamem="echo 1 | sudo tee /proc/sys/vm/drop_caches"
alias ip="ip add" # WSL
