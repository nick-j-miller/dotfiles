function fish_prompt
    set -l last_status $status

    _print_in_color "\n"(prompt_pwd) blue
    __fish_git_prompt " %s"
    _print_in_color "\n> " (_prompt_color_for_status $last_status)
end
