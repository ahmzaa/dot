#!/usr/bin/env bash

OS=`uname -o`

echo $OS

if [ $OS = "Darwin" ]; then
    echo "device is MacOS"
    source ~/.config/zsh/mac
fi
