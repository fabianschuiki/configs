#!/usr/bin/env bash

link() {
	FLAGS=
	echo -n "symlink $2 .. "
	if [ ! -e $2 ]; then
		FLAGS=-s
	elif [ $(readlink $2) != "$1" ]; then
		echo
		read -p "  already exists, overwrite? [y/n] " -n 1 -r
		echo "  "
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			FLAGS=-sf
		else
			echo "  skipped"
		fi
	else
		echo "up-to-date"
	fi
	if [ ! -z $FLAGS ]; then
		ln $FLAGS $1 $2
		echo "done"
	fi
}

if [ ! -d ~/.vim ]; then
	echo "- Making Vim directory"
	mkdir -p ~/.vim
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	echo "- Installing Vundle"
	git clone -b v0.10.2 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

DOTFILES=~/.dotfiles
link $DOTFILES/vimrc ~/.vimrc
link $DOTFILES/config/fish/functions ~/.config/fish/functions
link $DOTFILES/tmux/tmux.conf.symlink ~/.tmux.conf

# if [ "$(uname)" == "Darwin" ]; then
# fi
