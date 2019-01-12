#!/usr/bin/env bash

DOTVIMD=$HOME/.vim.d

DEPENDENCIES=(
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  https://raw.githubusercontent.com/skylerlee/vim-infra/master/autoload/infra.vim
)

function fetch_file {
  local file_url="$1"
  local dest_dir="$2"
  local file_name=${file_url##*/}
  mkdir -p $dest_dir
  curl -fsSL "$file_url" > $dest_dir/$file_name
}

function prefetch_plugins {
  echo "Installing dependencies"
  for dep in ${DEPENDENCIES[@]}; do
    echo "fetching: $dep"
    fetch_file $dep $DOTVIMD/autoload
  done
  echo "Done."
}

prefetch_plugins
