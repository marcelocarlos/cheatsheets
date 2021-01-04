#!/bin/bash
# install.sh
# Copyright 2014 - Marcelo Carlos (contact@marcelocarlos.com)
set -euo pipefail

APP_NAME=$(basename $0)

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------
function usage() {

  cat << EOF
Usage: $APP_NAME [options]

Options:
  -h      show this menu
EOF

}

function install_cs() {
  sudo ln -s $PWD/cheatsheets.sh /usr/local/bin/
  ln -s $PWD/cheatsheets $HOME/.cheatsheets
  # OS X
  if [ "$(uname)" == "Darwin" ]; then
    command -v brew >/dev/null && ln -s $PWD/autocompletion/cheatsheets.bash $(brew --prefix)/etc/bash_completion.d/
  else # Linux
    sudo ln -s $PWD/autocompletion/cheatsheets.bash /etc/bash_completion.d/
  fi
}

# ------------------------------------------------------------------------------
# Main part of the script
# ------------------------------------------------------------------------------
while getopts "h" OPTION
do
  case $OPTION in
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

install_cs
echo "All done."
