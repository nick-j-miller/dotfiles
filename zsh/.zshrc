# Environment variables:
export GOPATH="/Volumes/Storage/Projects/.go"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export WINEPREFIX="/Volumes/Storage/.wine"
export WINEARCH="win32"

# zsh:
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd notify
unsetopt beep nomatch
zstyle :compinstall filename '/Users/nick/.zshrc'
autoload -Uz compinit
compinit
DISABLE_AUTO_TITLE="true"

# Pure:
autoload -U promptinit && promptinit
prompt pure

# Aliases:
alias ls='ls -oAh --color --group-directories-first '
alias status='git status '
alias checkout='git checkout '
alias fetch='git fetch '
alias fap='git fetch && git pull '
alias merge='git merge '
alias pull='git pull '
alias push='git push '
alias add='git add '
alias stash='git stash '
alias t='osascript /usr/local/bin/change_terminal_color.scpt '
alias tt='__set_title '
alias vi='nvim '
alias vim='nvim '
alias subl='"/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" '

# Plugins:
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=14'
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Functions:
__set_title() {
	echo -e "\033];$1\007"
}

# Tabs:
tabs -4

# Keybindings:
bindkey "^[[3~"  delete-char
bindkey "^[3;5~" delete-char

