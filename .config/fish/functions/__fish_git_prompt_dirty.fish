function __fish_git_prompt_dirty --description '__fish_git_prompt helper, tells whether or not the current branch has tracked, modified files'
	set -l dirty

    set -l os
    command git diff --no-ext-diff --quiet --exit-code 2>/dev/null
    set os $status
    if test "$os" -ne "0" 
        set dirty $___fish_git_prompt_char_dirtystate
    end
    echo $dirty
end
