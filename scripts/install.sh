#!/usr/bin/env bash

DOTVIMD=$HOME/.vim.d
git clone https://github.com/skylerlee/vim.d.git $DOTVIMD
cd $DOTVIMD
source scripts/bootstrap.sh
ln -s $DOTVIMD/vimrc $HOME/.vimrc
