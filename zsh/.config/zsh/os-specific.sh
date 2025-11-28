#!/usr/bin/env bash

OS=`uname -o`
NAME=`uname -n`

if [ $OS = "Darwin" ]; then
    echo "device is MacOS"
    source ~/.config/zsh/mac
fi

if [ $NAME = "shadow" ]; then
    echo "device is Shadow"
    source ~/.config/zsh/shadow
fi
