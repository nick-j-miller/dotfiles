function __set_profile
    set -l theme "$argv[1]"

    switch $TERM_PROGRAM
        case "iTerm.app"
            echo -e "\033]50;SetProfile=$theme\a"
        case '*'
            osascript "/usr/local/bin/change_terminal_color.scpt" "$theme"
    end
end
