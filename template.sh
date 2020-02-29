#!/bin/bash

####################################################################
#                  Simple Template for Shell Script
# ==================================================================
# @Author:  qinhj@lsec.cc.ac.cn
# ------------------------------------------------------------------
# @Note:    To use "getopts" "let", we need bash.
# ------------------------------------------------------------------
# @History:
# 2020/02/29 v0.1.1 optimize(title, error code, ...)
# 2020/02/27 v0.1.0 optimize(color, ...)
# 2020/02/19 v0.0.0 init/create
####################################################################

#########################
#### Global Settings ####
#########################

## debug settings
PATH=.:$PATH
set -e # -ex
## script version
VERSION=0.1.1
## script options
COMMANDS="usage test"
COMMENTS="<command> [options]"
OPTIONS=":s:"
EXAMPLE0="usage"
EXAMPLE1="test -s 'hello world'"
## other variable
CONFIGS=
MESSAGE="hello world"

#########################
#### Function Region ####
#########################

### Private  Function ###

## hard code as Red
EchoError() {
  echo -e "\033[31m[Error ] $@\033[0m"
}

## hard code as LightBlue
EchoTitle() {
  echo -e "\033[36m$@\033[0m"
}

## hard code as Yellow
EchoSection() {
  echo -e "\033[33m$@\033[0m"
}

ShowTitle() {
  EchoTitle "Shell Script Template [Version: $VERSION]"
}

ShowUsage() {
  EchoSection "Usage:"
  echo "  $0 $COMMENTS"
}

ShowCommand() {
  EchoSection "Command:"
  echo "  usage show usage"
  echo "  test  quick test"
}

ShowOptions() {
  EchoSection "Options:"
  echo "  -s    demo string (default: $MESSAGE)"
}

ShowExample() {
  EchoSection "Example:"
  echo "  $0 $EXAMPLE0"
  echo "  $0 $EXAMPLE1"
}

ShowNotes() {
  EchoSection "Note:"
  echo "1. ..."
}

## Error Code ##
## 101: miss/invalid parameter
## 102: open/close file fail
ErrorHandle() {
  #echo "[Debug ] Error Code: $1"
  case $1 in
    1)    ## command not defined
      EchoError "Unknown Command: $COMMAND" && usage;;
    127)  ## command not found
      usage;;
    *)    ## do nothing
      ;;
  esac
}

#### Public Function ####

usage() {
  ShowTitle
  ShowUsage
  ShowCommand
  ShowOptions
  ShowExample
  #ShowNotes
}

test() {
  echo "[ Test ] Start: $@"
  echo "[ Test ] $MESSAGE"
  echo "[ Test ] Finish."
}

#########################
####  Main   Region  ####
#########################

## check inputs
if [ 0 -eq $# ]; then
  usage
  exit 0
fi

## get command
COMMAND="$1"
#echo "[Debug ] Command: $1"
shift

## parse option
while getopts $OPTIONS opt; do
  #echo "[Debug ] opt: $opt, arg: $OPTARG"
  case $opt in
    s)
      MESSAGE=$OPTARG
      echo "[Debug ] get message: $MESSAGE";;
    ?)
      EchoError "unknown option: $OPTARG"
      break
  esac
done
#echo "[Debug ] opt: $@, optind: $OPTIND"

## shift to remain options
shift $(($OPTIND - 1))
#echo "[Debug ] remain opt: $@"

## run command
([[ $COMMANDS =~ $COMMAND ]] && $COMMAND) || (ErrorHandle $?)
