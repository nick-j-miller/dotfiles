appdir = "/Applications"

tap "homebrew/cask"

# Packages:
brew "bash"
brew "bat"
brew "coreutils"
brew "cowsay"
brew "curl", args: ["with-openssl"]
brew "entr"
brew "fzf"
brew "git", args: ["with-blk-sha1", "with-curl", "with-gettext", "with-openssl", "with-pcre"]
brew "jq"
brew "lua@5.1", args: ["with-lldb", "with-toolchain"]
brew "htop"
brew "make"
brew "mpd", args: ["with-flac", "with-lame", "with-libmodplug", "with-libvorbis", "with-opus"]
brew "ncmpcpp", args: ["with-outputs"]
brew "neovim"
brew "netcat"
brew "noti"
brew "p7zip"
brew "pianobar"
brew "toilet"
brew "tree"
brew "unrar"
brew "wget", args: ["with-pcre"]
brew "zsh", args: ["with-unicode9"]
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

# Casks:
casks = {
    "bettertouchtool": "BetterTouchTool",
    "day-o": "Day-O",
    "docker": "Docker",
    "google-chrome": "Google Chrome",
    "onyx": "Onyx",
    "sequel-pro": "Sequel Pro",
    "sourcetree": "SourceTree",
    "spotify": "Spotify",
    "sublime-text": "Sublime Text",
    "the-unarchiver": "The Unarchiver",
    "visual-studio-code": "Visual Studio Code",
}

cask_args appdir: appdir
casks.each { |k, v|
    cask k.to_s unless `stat "#{appdir}/#{v}.app" >/dev/null 2>&1`
}
