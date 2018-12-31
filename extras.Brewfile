appdir = "/Applications"

# Extra packages:
brew "fortune"
brew "ffmpeg"
brew "gnupg"
brew "go"
brew "lftp"
brew "wine"
brew "winetricks"
brew "youtube-dl"

# Extra casks:
casks = {
    "battle-net": "Battle.net",
    "firefox": "Firefox",
    "plex-media-server": "Plex Media Server",
    "transmission": "Transmission",
    "virtualbox": "Virtualbox",
    "wireshark": "Wireshark",
    "xee": "Xee³",
}

cask_args appdir: appdir
casks.each_pair do |k, v|
    cask k unless `stat "#{appdir}/#{v}.app" >/dev/null 2>&1`
end
