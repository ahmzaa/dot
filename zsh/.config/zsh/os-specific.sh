#!/usr/bin/env bash

OS=`uname -o`
NAME=`uname -n`

# Other OS specific options here if required

if [ $OS = "Darwin" ]; then
    echo "OS is MacOS"
    source $ZDOTDIR/hosts/mac
fi


# Begin checking for host specific settings

if [ $NAME = "shadow" ]; then
    echo "Host is shadow"
    source $ZDOTDIR/hosts/shadow
fi

if [ $NAME = "CW-DYQN400C5P-L" ]; then
    echo "CW-DYQN400C5P-L"
    source $ZDOTDIR/hosts/CW-DYQN400C5P-L
fi


