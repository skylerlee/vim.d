" vimrc

set nocompatible  " be iMproved

let $DOTVIMD = expand('$HOME/.vim.d')

set rtp+=$DOTVIMD

call plug#begin($DOTVIMD . '/bundle')
Plug 'joshdick/onedark.vim'
call plug#end()

colorscheme onedark
