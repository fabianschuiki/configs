set nocompatible
filetype off
set laststatus=2
set encoding=utf-8
set tabstop=4

syntax enable   " enable syntax highlighting by default
set hidden      " leave hidden buffers open
set history=100 " save the last 100 commands, instead of just 8
set number      " add line numbers
let g:airline_powerline_fonts = 1

" Include and initialize Vundel
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'flazz/vim-colorschemes'
" Plugin 'reedes/vim-thematic'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

set background=dark
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

" Shortcut to toggle invisible characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬,trail:⎵
highlight NonText ctermfg=10
highlight SpecialKey ctermfg=10 ctermbg=8

set hlsearch
highlight ColorColumn ctermbg=7
call matchadd('ColorColumn', '\%81v', 100)
