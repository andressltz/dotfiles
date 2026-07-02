# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster-customized"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/dev/andressltz/dotfiles/zsh/custom

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # zsh-syntax-highlighting (não testado)
  zsh-autosuggestions
  F-Sy-H
)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# WSL alias
# alias morning=". ~/bomdia.sh"
# alias hybris="sh ~/dev/arezzo/ecommerce/hybris/bin/platform/hybrisserver.sh debug"
# alias intellij="sh /home/andreswinck/dev/tools/intellij/bin/idea.sh"
# alias lsh="ls -lah"
# alias chrome="google-chrome"
# alias limpa="echo 1 | sudo tee /proc/sys/vm/drop_caches"
# alias ip="ip add"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# Installed by brew install --cask zulu@8
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
# Installed by brew install --cask sapmachine11-jdk
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
# Installed by brew install --cask sapmachine17-jdk
export JAVA_17_HOME=$(/usr/libexec/java_home -v17)
# Installed by brew install openjdk@21
export JAVA_21_HOME=$(/usr/libexec/java_home -v21)

alias java8='export JAVA_HOME=$JAVA_8_HOME && export PATH="$JAVA_HOME/bin:$PATH"'
alias java11='export JAVA_HOME=$JAVA_11_HOME && export PATH="$JAVA_HOME/bin:$PATH"'
alias java17='export JAVA_HOME=$JAVA_17_HOME && export PATH="$JAVA_HOME/bin:$PATH"'
alias java21='export JAVA_HOME=$JAVA_21_HOME && export PATH="$JAVA_HOME/bin:$PATH"'

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

#export PATH=$PATH:/opt/homebrew/bin/virtualenv

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# Disable homebrew auto-update when install a new formula
export HOMEBREW_NO_AUTO_UPDATE=1
# export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

# Hybris
alias antall='java11 && hybrisbin && . ./setantenv.sh && ant all'
alias fullbuild='java11 && hybrisbin && ./fullbuild.sh'
alias hybrisdir='cd ~/dev/arezzo/hybris2011/hybris/'
alias hybrisbin='hybrisdir && cd bin/platform'
alias hybris='java11 && hybrisbin && ./hybrisserver.sh debug'

# Arezzo
alias buildfront='nvm use 10 && hybrisdir && cd bin/custom/arezzocostorefront/web/webroot/_ui/desktop/front-vendors && yarn build'
alias buildtheme='nvm use 10 && hybrisdir && cd bin/custom/arezzocostorefront/web/webroot/_ui/desktop/theme-marketplacezz && yarn build'

## Unimed
alias unimed='cd ~/dev/unimed'
alias peccommon='java8 && cd ~/dev/unimed/common/common-backend-parent && mvn clean install -DskipTests && cd ~/dev/unimed/common/common-backend-core && mvn clean install -DskipTests && cd ~/dev/unimed/common/common-web-parent && mvn clean install -DskipTests && cd ~/dev/unimed/common/common-web-core && mvn clean install -DskipTests && cd ~/dev/unimed/common/common-web-ui && mvn clean install -DskipTests'
alias pecback='java8 && cd ~/dev/unimed/pec/pec-wsclient && mvn clean install -DskipTests && cd ~/dev/unimed/pec/pec-backend && mvn clean install -DskipTests && cd ~/dev/unimed/pec/pec-webapp && mvn clean install -DskipTests'
alias peccibuildlog='java8 && cd ~/dev/unimed/pec && mvn clean verify -f pom.xml -U -Dspring.profiles.active=build -Duser.language=pt -Duser.country=BR -Duser.timezone=America/Bahia -l build_ci.log'
alias peccibuild='java8 && cd ~/dev/unimed/pec && mvn clean verify -f pom.xml -U -Dspring.profiles.active=build -Duser.language=pt -Duser.country=BR -Duser.timezone=America/Bahia'

# My Alias
alias home='cd ~'
alias dev='cd ~/dev'
alias wakeup='caffeinate -di'
alias week='date +%V'
alias localip="ipconfig getifaddr en0"
alias killtomcat="ps -ef | grep -i tomcat | grep -v grep | awk '{ print "kill -9 " $2}'|zsh"
# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
# Show X apps recents in Dock
alias setRecents="defaults write com.apple.dock show-recent-count -int 6"
# npm install -g http-server
alias server="http-server -c-1"
# alias http-server='docker run -p 8000:80 -v $(pwd):/usr/share/nginx/html nginx'
alias sshconnect='sshpass -p "pss" ssh -oStrictHostKeyChecking=no "usr"@"host" -p "port"'
alias killtomcat="ps -ef | grep -i tomcat | grep -v grep | awk '{ print "kill -9 " $2}'|zsh"
# Show/hide icons in Desktop. Use to share screen with privacity
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias intellij="open -na \"IntelliJ IDEA.app\""
alias idea="open -na \"IntelliJ IDEA.app\""
alias zshconfig="mate ~/.zshrc"
alias clean="git limpa && git branch -vv | grep 'gone]' | awk '{print $1}' | xargs git branch -D"
alias dns="sh ~/dev/andressltz/dotfiles/scripts/dns-test.sh"
alias meld='/Applications/Meld.app/Contents/MacOS/Meld'
alias k="kubectl"
alias m2="open ~/.m2"
alias gitls="sh ~/dev/andressltz/dotfiles/scripts/list_git_projects.sh"
alias gitbrd="sh ~/dev/andressltz/dotfiles/scripts/remove_deleted_branches.sh"

# Default
java21
