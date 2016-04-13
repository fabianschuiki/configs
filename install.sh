#!/usr/bin/env bash

link() {
	if [ ! -e $2 ]; then
		ln -s $1 $2
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

# if [ "$(uname)" == "Darwin" ]; then
# fi
