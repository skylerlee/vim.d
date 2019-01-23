#!/usr/bin/env bash

VIMPATH=${VIMPATH:-vim}
DOTVIMD=${DOTVIMD:-$HOME/.vim.d}

DEPENDENCIES=(
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  https://raw.githubusercontent.com/skylerlee/vim-infra/master/autoload/infra.vim
)

function init_colors {
  if which tput >/dev/null 2>&1; then
    local ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    RESET="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    RESET=""
  fi
}

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
  # find token in the given file
  local file=$1
  local token=$2
  local paren=$([ "$3" -eq "0" ] && echo '{' || echo '}')
  local ret=$(grep -on "\"\"\"\s\+$token\s\+$paren" $file)
  # returns line number
  echo ${ret%%:*}
}

function clip_code {
  # clip file by line numbers
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
  local vimrc=$DOTVIMD/vimrc
  local section1=$(clip_code $vimrc 'Base config')
  local section2=$(clip_code $vimrc 'Load plugins')
  # generate vimrc content
  local genrc="$section1"$'\n\n'"$section2"
  echo "Installing plugins"
  $VIMPATH -Nu <(echo "$genrc") +PlugInstall +qall
  echo "Done."
}

init_colors
prefetch_plugins
install_plugins

printf "$GREEN"
echo "Vim.d installed successfully."
printf "$RESET"
