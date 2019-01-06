# Paths:
set PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
set -x GOPATH /Volumes/Storage/Projects/go

# Environment variables:
set -x WINEPREFIX /Volumes/Storage/.wine
set -x WINEARCH win32
set -x FREETYPE_PROPERTIES truetype:interpreter-version=35

# Aliases:
alias ls="ls -ohAH --color --group-directories-first"
alias t="__set_profile"
alias tt="__set_title"
alias vi="nvim"
alias vim="nvim"
alias subl="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
alias g="grep --color=auto"
alias checkout="git checkout"
alias fap="git fetch --all && git pull"
alias stash="git stash"
alias merge="git merge"
alias push="git push"
alias commit="git commit"

# Fish:
set fish_prompt_pwd_dir_length 0
set fish_greeting
set __fish_git_prompt_showdirtystate true
