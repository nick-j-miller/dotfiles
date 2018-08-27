# Environment variables:
export GOPATH="$HOME/Projects/go"
export PATH="/Users/nick/.composer/vendor/bin:/usr/local/opt/llvm/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"
export WINEPREFIX="/Volumes/Storage/.wine"
export WINEARCH="win32"
export FREETYPE_PROPERTIES="truetype:interpreter-version=35"
export VM_DIRECTORY="/Volumes/Storage/.VirtualMachines"
export GREP_COLOR="01"
export XDEBUG_REMOTE_HOST=10.254.254.254

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
PURE_PROMPT_SYMBOL=">"

# Aliases:
alias ls='ls -oAhH --color --group-directories-first '
alias status='git status '
alias checkout='git checkout '
alias fetch='git fetch '
alias fap='git fetch && git pull '
alias merge='git merge '
alias pull='git pull '
alias push='git push '
alias add='git add '
alias stash='git stash '
alias commit='git commit -m '
alias t='osascript /usr/local/bin/change_terminal_color.scpt '
alias tt='__set_title '
alias vi='nvim '
alias vim='nvim '
alias subl='"/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" '
alias g='grep --color=auto '

# Plugins:
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=14'
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Functions:
__set_title() {
	echo -e "\033];$*\007"
}

pandora() {
    t dark
    tt Pandora
    pianobar 2>/dev/null
}

music() {
    t dark
    ncmpcpp
}

fixme() {
    stty sane
}

clear() {
    command clear
    printf '\e[3J'
}

# Tabs:
tabs -4

# Keybindings:
bindkey "^[[3~"  delete-char
bindkey "^[3;5~" delete-char
bindkey "^U" backward-kill-line
bindkey "^X\x7f" backward-kill-line
bindkey "^X^_" redo

