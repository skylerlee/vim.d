" github.com/skylerlee/vim.d/vimrc
" Copyright (C) 2018, Skyler.
" Use of this source code is governed by the MIT license that can be
" found in the LICENSE file.

set nocompatible  " be iMproved

let g:infra_path_root = expand('$HOME/.vim.d')

execute 'set rtp+=' . g:infra_path_root

" Initialize plugins
let s:settings = infra#load_json('settings.json')

function s:register(name, conf)
  Plug a:name, a:conf
endfunction

call plug#begin(infra#path_resolve('bundle'))
call infra#iter_dict(s:settings, function('s:register'))
call plug#end()
" End

" Set linenumber
set number

" Set colorscheme
colorscheme onedark

" Set powerline
set laststatus=2
let g:lightline = { 'colorscheme': 'onedark' }

function s:reload_settings()
endfunction

function s:post_vim_loaded()
  let target = infra#path_resolve('settings.json')
  call infra#eval('autocmd BufWritePost %s call s:reload_settings()', target)
endfunction

autocmd VimEnter * call s:post_vim_loaded()
