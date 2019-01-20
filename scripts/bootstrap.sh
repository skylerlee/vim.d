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
  local ret=$(grep -Pon "\"{3}\s*$token\s*$paren" $file)
  echo ${ret%%:*}
}

function clip_code {
  local file=$1
  local token=$2
  local begin=$(find_line $file "$token" 0)
  local end=$(find_line $file "$token" 1)
  if [[ -z $begin && -z $end ]]; then
    echo "token not found: '$token'"
    exit 1
  else
    sed -n "$((begin + 1)),$((end - 1))p" $file
  fi
}

function install_plugins {
  local section1=$(clip_code vimrc 'Base config')
  local section2=$(clip_code vimrc 'Load plugins')
  local content="$section1"$'\n\n'"$section2"
  echo "Installing plugins"
  vim -Nu <(echo "$content") +PlugInstall +qall
  echo "Done."
}

prefetch_plugins
install_plugins
