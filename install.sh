#!/bin/bash
# install.sh
# Copyright 2014 - Marcelo Carlos (contact@marcelocarlos.com)

# ------------------------------------------------------------------------------
# Settings
# ------------------------------------------------------------------------------
APP_NAME=$(basename $0)
APP_PATH=$(dirname "$0")
LINK_FILES=0

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------
function usage() {

  cat << EOF
Usage: $APP_NAME [options] <path>

Options:
  -l      link files instead of copying
  -h      show this menu

EOF

}

function install_it() {

  if [ $LINK_FILES == 0 ]; then
    sudo cp cheatsheets.sh /usr/local/bin/
    cp -r cheatsheets $HOME/.cheatsheets
    # OS X
    if [ "$(uname)" == "Darwin" ]; then
      command -v brew >/dev/null && cp autocompletion/cheatsheets.bash $(brew --prefix)/etc/bash_completion.d/
    else # Linux
      sudo cp autocompletion/cheatsheets.bash /etc/bash_completion.d/
    fi
  else
    sudo ln -s $PWD/cheatsheets.sh /usr/local/bin/
    ln -s $PWD/cheatsheets $HOME/.cheatsheets
    # OS X
    if [ "$(uname)" == "Darwin" ]; then
      command -v brew >/dev/null && ln -s $PWD/autocompletion/cheatsheets.bash $(brew --prefix)/etc/bash_completion.d/
    else # Linux
      sudo ln -s $PWD/autocompletion/cheatsheets.bash /etc/bash_completion.d/
    fi
  fi

}

# ------------------------------------------------------------------------------
# Main part of the script
# ------------------------------------------------------------------------------
while getopts "hl" OPTION
do
  case $OPTION in
    l)
      LINK_FILES=1
      ;;
    h)
      usage
      exit 0
      ;;
    ?)
      usage
      exit 128
      ;;
  esac
done

install_it $1
