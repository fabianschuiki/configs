#!/usr/bin/env bash
# Copyright (c) 2016 Fabian Schuiki
# Installs the dotfiles on the system.

link() {
	FLAGS=
	if [ ! -L "$2" ] && [ ! -e "$2" ]; then
		echo "-- Linking $2"
		FLAGS=-s
	elif [ "$(readlink "$2")" != "$1" ]; then
		echo "-- Linking $2"
		read -p "   already exists, overwrite? [y/n] " -n 1 -r
		echo "  "
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			if [ "$(uname)" == "Darwin" ]; then
				FLAGS=-sFf
			else
				FLAGS=-sf
			fi
		else
			echo "   skipped"
		fi
	fi
	if [ ! -z $FLAGS ]; then
		if [ "$(uname)" == "Darwin" ]; then
			ln -h $FLAGS "$1" "$2"
		else
			ln -T $FLAGS "$1" "$2"
		fi
	fi
}

if [ ! -d ~/.vim ]; then
	echo "-- Making Vim directory"
	mkdir -p ~/.vim
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	echo "-- Installing Vundle"
	REPODIR=~/.vim/bundle/Vundle.vim
	git clone -n https://github.com/VundleVim/Vundle.vim.git $REPODIR
	pushd $REPODIR
	git checkout v0.10.2
	popd
fi

if [ "$(uname)" == "Darwin" ]; then
	DOTFILES="$PWD/$(dirname $BASH_SOURCE)"
else
	DOTFILES=$(readlink -m "$(dirname $BASH_SOURCE)")
fi
link $DOTFILES/vimrc ~/.vimrc
link $DOTFILES/config/fish/ ~/.config/fish
link $DOTFILES/tmux/tmux.conf.symlink ~/.tmux.conf

SUBL_SRC=$DOTFILES/config/sublime-text-3/Packages/User
if [ "$(uname)" == "Darwin" ]; then
	SUBL_DST=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
else
	SUBL_DST=~/.config/sublime-text-3/Packages/User
fi

link "$SUBL_SRC/Preferences.sublime-settings" "$SUBL_DST/Preferences.sublime-settings"
link "$SUBL_SRC/Markdown.sublime-settings" "$SUBL_DST/Markdown.sublime-settings"
link "$SUBL_SRC/Diff.sublime-settings" "$SUBL_DST/Diff.sublime-settings"
