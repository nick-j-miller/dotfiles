#!/usr/bin/env bash

ARGC=$#
ARGV=$*
OS="$(uname -a | xargs -n1 | head -n1)"
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

if [ "$OS" != "Darwin" ]; then
	echo "Script can only be run on macOS" >&2
	exit 1
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
CLTOOLS=$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables)

if [ $? -eq 1 ]; then
	echo "Installing $TOPIC..."
	touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
	local prod="$(
		softwareupdate -l
			| grep "\*.*Command Line"
			| head -n1 | awk -F"*" '{print $2}'
			| sed -e 's/^ *//'
			| tr -d '\n'
	)"
	softwareupdate -i "$prod" --verbose
	local ret=$?

	if [ $ret -ne 0 ]; then
		exit_if $ret "Couldn't install ${TOPIC}!"
	fi
fi

# Install Homebrew:
TOPIC="Homebrew"
HOMEBREW=$(command -v brew)

if [ -z "$HOMEBREW" ]; then
	echo "Installing $TOPIC..."
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

# Install Homebrew packages:
TOPIC="Homebrew packages and casks"
echo "Installing $TOPIC..."
brew bundle --file=base.Brewfile
ret=$?

if [ $ret -ne 0 ]; then
	exit_if $ret "Couldn't install ${TOPIC}!"
fi

TOPIC="Extra packages and casks"
echo "Installing $TOPIC..."
if [ -n "$BREW_INSTALL_EXTRAS" ]; then
	brew bundle --file=extras.Brewfile
	ret=$?

	if [ $ret -ne 0 ]; then
		exit_if $ret "Couldn't install ${TOPIC}!"
	fi
fi

# zsh pure prompt:
PURE_DIR="/usr/local/share/zsh-pure"
TOPIC="Pure prompt"
echo "Installing $TOPIC..."

if [[ ! -d "$PURE_DIR" ]]; then
	git clone "https://github.com/sindresorhus/pure" "/usr/local/share/zsh-pure" \
		&& ln -s "/usr/local/share/zsh-pure/pure.zsh" "/usr/local/share/zsh/site-functions/prompt_pure_setup" \
		&& ln -s "/usr/local/share/zsh-pure/async.zsh" "/usr/local/share/zsh/site-functions/async"
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
