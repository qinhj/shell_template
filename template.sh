#!/bin/bash

####################################################################
#                  Simple Template for Shell Script
# ==================================================================
# @Author:  qinhj@lsec.cc.ac.cn
# ------------------------------------------------------------------
# @Note:    To use getopts, we need bash.
# ------------------------------------------------------------------
# @History:
# 2020/02/19 v0.0.0 init
####################################################################

#### Global Settings ####

## debug settings
#set -x
## script version
VERSION=0.0.0
## script options
COMMAND="usage"
OPTIONS=":vs:"
COMMENT="<command> [-v] [-s <string>]"
EXAMPLE="test -v -s 'hello world'"
## other variable
MESSAGE="hello world"

#### Function Region ####

Usage() {
    echo "Shell Script Template [Version: $VERSION]"
    echo "Usage:"
    echo "  $0 $COMMENT"
    echo "Commands:"
    echo "  usage   show usage"
    echo "  test    quick test"
    echo "Options:"
    echo "  -v      show version"
    echo "  -s      demo string"
    echo "Examples:"
    echo "  $0 $EXAMPLE"
}

Test() {
    echo "[ Test ] Start."
    echo "[ Test ] $MESSAGE"
    echo "[ Test ] Finish."
}

####  Main   Region  ####

## check inputs
if [ 0 -eq $# ]; then
    echo "[Error ] Missing necessary arguments!"
    Usage
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
        v)
            echo "$0 Version: $VERSION";;
        s)
            MESSAGE=$OPTARG
            echo "[Debug ] get message: $MESSAGE";;
        ?)
            echo "[Error ] Unknown option: $OPTARG"
            break
    esac
done
## option debug
#echo "[Debug ] opt: $@, optind: $OPTIND"
#shift $(($OPTIND - 1))
#echo "[Debug ] remain opt: $@"

## run command
case $COMMAND in
    usage)
        Usage
        ;;
    test)
        Test
        ;;
    *)
        echo "[Error ] Unknown Command: $COMMAND"
        Usage
        ;;
esac
