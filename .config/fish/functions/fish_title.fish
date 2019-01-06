function fish_title
    set -l title ""

    if test -n "$__custom_title"
        set title "$__custom_title"
    else
        set title (super_short_pwd) "—" (status current-command)
    end

    echo "$title"
end
