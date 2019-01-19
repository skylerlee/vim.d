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

function find_line {
  local file=$1
  local token=$2
  local paren=$([ "$3" -eq "0" ] && echo '{' || echo '}')
  local ret=$(grep -Pon "\"\s*$token\s*$paren" $file)
  echo ${ret%%:*}
}

function clip_code {
  local file=$1
  local token=$2
  local begin=$(find_line $file "$token" 0)
  local end=$(find_line $file "$token" 1)
  sed -n "$((begin + 1)),$((end - 1))p" $file
}

function install_plugins {
  echo "Installing plugins"
  vim +PlugInstall +qall
  echo "Done."
}

prefetch_plugins
install_plugins
