#!/usr/bin/env bash

# Exit with a message if $1 is nonzero.
# $1: error code
# $2: message
function exit_if() {
    if [ "${1}" -ne 0 ]; then
        echo "${2}" >&2
        exit "${1}"
    fi
}

# Ensure SIGINT exits entire script instead of the current task:
trap exit SIGINT

if [ "$(uname -a | xargs -n1 | head -n1)" != "Darwin" ]; then
    exit_if 1 "Script can only be run on macOS"
fi

# Defaults:
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock tilesize 64
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
killall Dock 2>/dev/null && killall Finder 2>/dev/null

# Install Command Line Tools for Xcode:
TOPIC="Command Line Tools for Xcode"
CLTOOLS="$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables)"

if [ $? -eq 1 ]; then
    echo "Installing ${TOPIC}..."
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    local prod="$(
        softwareupdate -l
            | grep "\*.*Command Line"
            | head -n1 | awk -F"*" '{print $2}'
            | sed -e 's/^ *//'
            | tr -d '\n'
    )"
    softwareupdate -i "${prod}" --verbose
    ret=$?

    if [ $ret -ne 0 ]; then
        exit_if $ret "Couldn't install ${TOPIC}!"
    fi
fi

# Install Homebrew:
TOPIC="Homebrew"
HOMEBREW="$(command -v brew)"

if [ -z "${HOMEBREW}" ]; then
    echo "Installing ${TOPIC}..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ret=$?

    if [ $ret -ne 0 ]; then
        exit_if $ret "Couldn't install ${TOPIC}!"
    fi
fi

# Ensure `brew doctor` doesn't report anything:
brew doctor
ret=$?

if [[ $ret -ne 0 && "${IGNORE_BREW_DOCTOR}" -ne 1 ]]; then
    exit_if $ret "\`brew doctor\` reported errors/warnings - fix before proceeding or set IGNORE_BREW_DOCTOR=1"
fi

# Tap `brew bundle` and install Homebrew packages:
TOPIC="Homebrew packages and casks"
echo "Installing ${TOPIC}..."
brew bundle --file=base.Brewfile
ret=$?

if [ $ret -ne 0 ]; then
    exit_if $ret "Couldn't install ${TOPIC}!"
fi

# Install extra casks and packages, if specified:
if [ "${BREW_INSTALL_EXTRAS}" -ne 1 ]; then
    TOPIC="Extra packages and casks"
    echo "Installing ${TOPIC}..."
    brew bundle --file=extras.Brewfile
    ret=$?

    if [ $ret -ne 0 ]; then
        exit_if $ret "Couldn't install ${TOPIC}!"
    fi
fi

# Install zsh pure prompt:
PURE_DIR="/usr/local/share/zsh-pure"

if [[ ! -d "${PURE_DIR}" ]]; then
    TOPIC="zsh pure prompt"
    echo "Installing ${TOPIC}..."

    git clone "https://github.com/sindresorhus/pure" "${PURE_DIR}" \
        && ln -s "${PURE_DIR}/pure.zsh" \
            "/usr/local/share/zsh/site-functions/prompt_pure_setup" \
        && ln -s "${PURE_DIR}/async.zsh" \
            "/usr/local/share/zsh/site-functions/async"
    ret=$?

    if [ $ret -ne 0 ]; then
        exit_if $ret "Couldn't install ${TOPIC}!"
    fi
fi

# Storage symlinks:
if [[ -n "${SYMLINK_USER_DIRS}" && -d "/Volumes/Storage" ]]; then
    dirs=("Documents" "Movies" "Music" "Pictures" "Projects")


    for dir in "${dirs}"; do
        mkdir -p "~/${dir}" \
            && rmdir "~/${dir}" \
            && ln -s "/Volumes/Storage/${dir}" "~/${dir}"
    done

    [[ -L "/Storage" ]] || ln -s "/Volumes/Storage" "/Storage"
fi

# Copy utility configuration files:
cp -Ri .config/* ~/.config
cp -i .zshrc ~
