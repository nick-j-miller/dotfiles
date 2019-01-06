function super_short_pwd
    set -l realhome ~
    string replace -r '^'"$realhome"'($|/)' '~$1' (basename $PWD)
end
