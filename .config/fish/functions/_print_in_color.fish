function _print_in_color
    set -l string $argv[1]
    set -l color $argv[2]

    set_color $color
    printf $string
    set_color normal
end
