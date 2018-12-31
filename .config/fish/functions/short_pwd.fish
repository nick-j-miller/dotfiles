function short_pwd
	set -l realhome ~
	string replace -r '^'"$realhome"'($|/)' '~$1' $PWD
end
