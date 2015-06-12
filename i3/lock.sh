#!/bin/bash
scrot /tmp/i3lock.png
convert /tmp/i3lock.png \
	-level 0%,400% \
	-blur 0x4 \
	/tmp/i3lock_proc.png
i3lock -e -i /tmp/i3lock_proc.png
