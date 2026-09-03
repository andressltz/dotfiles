cd ~
mkdir dev
cd dev
mkdir home

ln -s ~/.zshrc ~/dev/home/.zshrc
ln -s ~/.zsh_history ~/dev/home/.zsh_history
ln -s ~/.gitconfig ~/dev/home/.gitconfig

git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/F-Sy-H
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting