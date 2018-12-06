" vimrc

set nocompatible  " be iMproved

let $DOTVIMD = expand('<sfile>:p:h')

set rtp+=$DOTVIMD

call plug#begin($DOTVIMD . 'bundle')
call plug#end()
