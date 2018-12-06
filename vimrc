" vimrc

set nocompatible  " be iMproved

let $DOTVIMD = expand('$HOME/.vim.d')

set rtp+=$DOTVIMD

call plug#begin($DOTVIMD . 'bundle')
call plug#end()
