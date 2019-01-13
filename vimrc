" github.com/skylerlee/vim.d/vimrc
" Copyright (C) 2018, Skyler.
" Use of this source code is governed by the MIT license that can be
" found in the LICENSE file.

set nocompatible  " be iMproved

let g:infra_path_root = expand('$HOME/.vim.d')

set rtp+=$DOTVIMD

" Initialize plugins
let s:settings = infra#load_json('settings.json')

function s:register(name, conf)
  Plug a:name, a:conf
endfunction

call plug#begin(infra#path_resolve('bundle'))
call infra#iter_dict(s:settings, function('s:register'))
call plug#end()
" End

" Set colorscheme
" colorscheme onedark

function s:reload_settings()
  luafile $DOTVIMD/scripts/generate.lua
endfunction

function s:watch_settings_file()
  autocmd BufWritePost $DOTVIMD/settings.json call s:reload_settings()
endfunction

autocmd VimEnter * call s:watch_settings_file()
