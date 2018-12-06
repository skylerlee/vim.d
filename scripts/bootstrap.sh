#!/usr/bin/env bash

DOTVIMD=$HOME/.vim.d

function fetch_plugin {
  local file_url="$1"
  local dest_dir="$2"
  local file_name=${file_url##*/}
  curl -fsSL "$file_url" > $dest_dir/$file_name
}

function prefetch_plugins {
  mkdir -p $DOTVIMD/autoload
  fetch_plugin https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim $DOTVIMD/autoload
}

prefetch_plugins
