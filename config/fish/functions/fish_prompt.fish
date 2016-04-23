# Copyright (c) 2015-2016 Fabian Schuiki
# Personalized fish command prompt.

# Configure the git prompt.
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

function fish_prompt --description "Displays the prompt"

	set -l last_status $status

	# Determine the abbreviated hostname.
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname | cut -d . -f 1)
	end

	# Determine the delimiter and color depending on the current user.
	switch $USER
		case root
			if not set -q __fish_prompt_cwd
				if set -q fish_color_cwd_root
					set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
				else
					set -g __fish_prompt_cwd (set_color $fish_color_cwd)
				end
			end
		case '*'
			if not set -q __fish_prompt_cwd
				set -g __fish_prompt_cwd (set_color $fish_color_cwd)
			end
	end

	# Print user, hostname, and path.
	printf "%s@%s %s%s%s%s" \
		$USER $__fish_prompt_hostname \
		"$__fish_prompt_cwd" (prompt_pwd) (set_color $fish_color_normal) \
		(__fish_git_prompt)

	# Append the status if it is non-zero.
	if [ $last_status -ne 0 ]
		printf " %s✖ %d%s" \
			(set_color $fish_color_error) \
			$last_status \
			(set_color $fish_color_normal)
	end

	printf "\n❯ " $user_prompt

end
