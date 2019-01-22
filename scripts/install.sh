#!/usr/bin/env bash

DOTVIMD=$HOME/.vim.d
git clone https://github.com/skylerlee/vim.d.git $DOTVIMD
source $DOTVIMD/scripts/bootstrap.sh
ln -s $DOTVIMD/vimrc $HOME/.vimrc
