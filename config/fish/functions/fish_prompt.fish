# Copyright (c) 2015-2016 Fabian Schuiki
# Personalized fish command prompt.

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
	printf "%s@%s %s%s%s" \
		$USER $__fish_prompt_hostname \
		"$__fish_prompt_cwd" (prompt_pwd) (set_color $fish_color_normal)

	# Append git prompt if we're on a locally mounted file system.
	if contains (uname) Darwin
		__fish_git_prompt
	else
		set -l fstype (df -P -T . | tail -n +2 | awk '{print $2}')
		if contains $fstype ext4 btrfs
			__fish_git_prompt
		end
	end

	# Append the status on the right-hand side.
	set -l status_remark_color
	set -l status_remark
	if [ $last_status -ne 0 ]
		set status_remark_color $fish_color_error
		set status_remark  (printf "✖ %d" $last_status)
	else
		set status_remark_color green
		set status_remark "✔"
	end
	if [ $fish_prompt_status_align_right ]
		tput hpa (math $COLUMNS - (string length -- $status_remark) - 4)
		printf "[ %s%s%s ]" (set_color $status_remark_color) "$status_remark" (set_color $fish_color_normal)
	else
		printf " %s%s%s" (set_color $status_remark_color) "$status_remark" (set_color $fish_color_normal)
	end

	printf "\n❯ " $user_prompt

end
