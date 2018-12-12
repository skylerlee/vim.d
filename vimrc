" github.com/skylerlee/vim.d/vimrc
" Copyright (C) 2018, Skyler.
" Use of this source code is governed by the MIT license that can be
" found in the LICENSE file.

set nocompatible  " be iMproved

let $DOTVIMD = expand('$HOME/.vim.d')

set rtp+=$DOTVIMD

" Initialize plugins
call plug#begin('$DOTVIMD/bundle')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
call plug#end()
" End

" Set colorscheme
colorscheme onedark

function s:reload_settings()
  luafile $DOTVIMD/scripts/generate.lua
endfunction

function s:watch_settings_file()
  autocmd BufWritePost $DOTVIMD/settings.json call s:reload_settings()
endfunction

autocmd VimEnter * call s:watch_settings_file()
