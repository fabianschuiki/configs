#!/usr/bin/env bash

link() {
	if [ ! -e $2 ]; then
		ln -s $1 $2
	fi
}

DOTFILES=~/.dotfiles
link $DOTFILES/vimrc ~/.vimrc
link $DOTFILES/config/fish/functions ~/.config/fish/functions

# if [ "$(uname)" == "Darwin" ]; then
# fi
