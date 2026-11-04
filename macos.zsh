# JDKs Env - Only macOS

# Installed by brew install --cask zulu@8
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
# Installed by brew install --cask sapmachine11-jdk
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
# Installed by brew install --cask sapmachine17-jdk
export JAVA_17_HOME=$(/usr/libexec/java_home -v17)
# Installed by brew install openjdk@21
export JAVA_21_HOME=$(/usr/libexec/java_home -v21)

alias java8='export JAVA_HOME=$JAVA_8_BREW_HOME && export PATH="$JAVA_HOME/bin:$PATH"'
alias java11='export JAVA_HOME=$JAVA_11_BREW_HOME && export PATH="$JAVA_HOME/bin:$PATH"'
alias java17='export JAVA_HOME=$JAVA_17_BREW_HOME && export PATH="$JAVA_HOME/bin:$PATH"'
alias java21='export JAVA_HOME=$JAVA_21_BREW_HOME && export PATH="$JAVA_HOME/bin:$PATH"'

# My Alias macOS
# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

alias meld='/Applications/Meld.app/Contents/MacOS/Meld'
alias m2="open ~/.m2"
