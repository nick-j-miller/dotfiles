function _prompt_color_for_status
	if test (count $argv) -gt 1 -o "$argv[1]" = "0"
		echo $fish_color_normal
	else
		echo $fish_color_error
	end
end
