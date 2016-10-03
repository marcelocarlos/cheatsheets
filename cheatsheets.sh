#!/bin/bash

# ------------------------------------------------------------------------------
# Settings
# ------------------------------------------------------------------------------
VERSION="1.0.0"
# GLOBAL VARIABLES
APP_NAME=$(basename $0)
APP_PATH=$(dirname "$0")
CONFIG_FILENAME=".cheatsheetsc"

# These colours are supported by the cheat sheet files
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

BOLD=$(tput bold)
RESET=$(tput sgr0)

tput sgr0

# ------------------------------------------------------------------------------
# Config file handling
# ------------------------------------------------------------------------------
function saveConfigFile() {
  echo "# Config file for ${APP_NAME} ${VERSION}

# Cheat list files path
CHEAT_LIST_PATH=${HOME}/.cheatsheets/
" > ~/$CONFIG_FILENAME
}

if [ ! -f ~/$CONFIG_FILENAME ]; then
  echo "The config file does not exist!"
  saveConfigFile
  if [ $? -eq 0 ]; then
    echo "[ ${YELLOW}INFO${RESET} ] Created a new config file"
  else
    echo "[ ${RED}ERROR]${RESET} Could not create a config file!"
    exit 11
  fi
fi

# ------------------------------------------------------------------------------
# Usage
# ------------------------------------------------------------------------------
function usage() {
  # gets the values from the config file
  source ~/$CONFIG_FILENAME

  cat << EOF
Usage: $APP_NAME [options] <cheatsheet>

Options:
  -l         list available cheat lists
  -h         show this menu
  -v         show version

To create more cheat sheets, just create a new file at ${CHEAT_LIST_PATH}

EOF
}

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------
function list_cheat_files() {
  echo "------------------------------------------------------------------"
  echo " List of available cheat sheets"
  echo -e " ${BLACK}(Cheat sheets files are at: ${CHEAT_LIST_PATH})${RESET}"
  echo "------------------------------------------------------------------"
  echo ""
  for entry in `find "$CHEAT_LIST_PATH"/ -maxdepth 2 -type f | sort`
  do
    echo "  - $(basename $entry)"
  done
  echo ""
}

function display_cheats() {
  if [ -f "$CHEAT_LIST_PATH/$1" ]; then
    echo "------------------------------------------------------------------"
    echo -e " Displaying cheat sheet for ${BOLD}$1${RESET}"
    echo "------------------------------------------------------------------"
    echo ""
    cat $CHEAT_LIST_PATH/$1
    echo ""
  else
    echo ""
    echo -e "Cheat sheet for ${BOLD}$1${RESET} doesn't exist!"
    echo ""
    exit 12
  fi
}

# ------------------------------------------------------------------------------
# Main part of the script
# ------------------------------------------------------------------------------

#loading configuration file
source ~/$CONFIG_FILENAME

# a colon means that a parameter is expected after the option selected
while getopts "lvh" OPTION
do
  case $OPTION in
    l)
      list_cheat_files
      exit 0
      ;;
    v)
      echo "$APP_NAME $VERSION"
      exit 0
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
# shift all processed options away, so it brings the positional parameters to the correct position
shift $((OPTIND-1))

if [ $# -ne "1" ]; then
  usage
  exit 11;
else
  display_cheats $1
  exit 0
fi
