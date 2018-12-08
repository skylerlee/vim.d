" vimrc

set nocompatible  " be iMproved

let $DOTVIMD = expand('$HOME/.vim.d')

set rtp+=$DOTVIMD

call plug#begin($DOTVIMD . '/bundle')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
call plug#end()

colorscheme onedark

function s:reload_settings()
  luafile $DOTVIMD/scripts/generate.lua
endfunction

function s:watch_settings_file()
  autocmd BufWritePost $DOTVIMD/settings.json call s:reload_settings()
endfunction

call s:watch_settings_file()
