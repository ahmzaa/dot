#!/usr/bin/env bash

OS=`uname -o`
NAME=`uname -n`

# Other OS specific options here if required

if [ $OS = "Darwin" ] && [ -f "$ZDOTDIR/hosts/mac" ]; then
    echo "OS is MacOS"
    source $ZDOTDIR/hosts/mac
fi


# Begin checking for host specific settings.
# NOTE: the CW-DYQN400C5P-L host file ships in the `work` stow package, so it
# only exists once `work` is stowed. Guard with [ -f ] so a bare checkout on
# the work hostname doesn't error before the package is installed.

if [ $NAME = "shadow" ] && [ -f "$ZDOTDIR/hosts/shadow" ]; then
    echo "Host is shadow"
    source $ZDOTDIR/hosts/shadow
fi

if [ $NAME = "CW-DYQN400C5P-L" ] && [ -f "$ZDOTDIR/hosts/CW-DYQN400C5P-L" ]; then
    echo "CW-DYQN400C5P-L"
    source $ZDOTDIR/hosts/CW-DYQN400C5P-L
fi


