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

if [ $NAME = "i-prefer-linux.roam.internal" ]; then
    echo "Host is i-prefer-linux.roam.internal"
    source $ZDOTDIR/hosts/i-prefer-linux.roam.internal
fi
