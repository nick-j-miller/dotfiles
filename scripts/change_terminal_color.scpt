on run argv
    tell application "Terminal" to set current settings of selected tab of window 1 to (first settings set whose name is (item 1 of argv))
end run

