#!/usr/bin/env bash

# Defaults:
defaults write com.apple.dock persistent-apps -array;
defaults write com.apple.dock tilesize 64;
defaults write com.apple.dock autohide -bool true;
defaults write com.apple.dock autohide-delay -float 0;
defaults write NSGlobalDomain AppleShowAllExtensions -bool true;
killall Dock 2>/dev/null
	&& killall Finder 2>/dev/null;

# Xcode command line tools:
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
	grep "\*.*Command Line" |
	head -n 1 | awk -F"*" '{print $2}' |
	sed -e 's/^ *//' |
	tr -d '\n')
softwareupdate -i "$PROD" --verbose;

if [ $? -ne 0 ]; then
	echo "Couldn't install Xcode command line tools" >&2
	exit 1
fi;

# Homebrew:
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";

if [ $? -ne 0 ]; then
	echo "Couldn't install Homebrew" >&2;
	exit 1;
fi;

# Ensure `brew doctor` doesn't report anything:
brew doctor

if [ $? -ne 0 ]; then
	echo "brew doctor reported errors/warnings. Fix before proceeding";
	exit 1;
fi;


if [ "$?" -ne 0 ]; then
	echo "Couldn't install $TOPIC ($ret)" >&2
	exit $ret
fi

# Install Homebrew packages:
TOPIC="Homebrew packages and casks"
echo "Installing $TOPIC..."
brew bundle --file=base.Brewfile

TOPIC="Extra packages and casks"
echo "Installing $TOPIC..."
if [ -n "$BREW_INSTALL_EXTRAS" ]; then
	brew bundle --file=extras.Brewfile
fi

# zsh pure prompt:
git clone "https://github.com/sindresorhus/pure" "/usr/local/share/zsh-pure"
	&& ln -s "/usr/local/share/zsh-pure/pure.zsh" "/usr/local/share/zsh/site-functions/prompt_pure_setup"
	&& ln -s "/usr/local/share/zsh-pure/async.zsh" "/usr/local/share/zsh/site-functions/async";

# Storage symlinks:
if [ -d "/Volumes/Storage" ]; then
	rmdir "/Users/$(whoami)/Documents"
		&& rmdir "/Users/$(whoami)/Movies"
		&& rmdir "/Users/$(whoami)/Music"
		&& rmdir "/Users/$(whoami)/Pictures";
	ls -s "/Volumes/Storage/Documents" "/Users/$(whoami)/Documents"
		&& ls -s "/Volumes/Storage/Movies" "/Users/$(whoami)/Movies"
		&& ls -s "/Volumes/Storage/Music" "/Users/$(whoami)/Music"
		&& ls -s "/Volumes/Storage/Pictures" "/Users/$(whoami)/Pictures";
	ln -s "/Volumes/Storage" "/Storage";
	ln -s "/Volumes/Storage/Projects" "/Users/$(whoami)/Projects";
fi;

# Cask stuff:
brew tap caskroom/cask;

while IFS='' read -r line || [[ -n "$line" ]]; do
	brew install $line

	if [ $? -ne 0 ]
	then
		printf "Unable to install $line; you may need to install it manually\n"
	fi
done < "./casks.txt";