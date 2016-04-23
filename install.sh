#!/usr/bin/env bash

link() {
	FLAGS=
	if [ ! -L $2 ] && [ ! -e $2 ]; then
		echo "-- Linking $2"
		FLAGS=-s
	elif [ $(readlink $2) != "$1" ]; then
		echo "-- Linking $2"
		read -p "   already exists, overwrite? [y/n] " -n 1 -r
		echo "  "
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			FLAGS=-sf
		else
			echo "   skipped"
		fi
	fi
	if [ ! -z $FLAGS ]; then
		ln -T $FLAGS $1 $2
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

DOTFILES=$(readlink -m $(dirname $BASH_SOURCE))
link $DOTFILES/vimrc ~/.vimrc
link $DOTFILES/config/fish/ ~/.config/fish
link $DOTFILES/tmux/tmux.conf.symlink ~/.tmux.conf

# if [ "$(uname)" == "Darwin" ]; then
# fi
