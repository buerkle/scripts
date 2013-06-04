#!/bin/bash

EDITOR=vs

if [ -z "$1" ]; then
    exec $EDITOR
fi

if [ -e "$1" ]; then
    exec $EDITOR $1
fi

FILE=$(find . -iname "$1" | sort)
FILES=( $FILE )
COUNT=${#FILES[@]}

if [ "0" == $COUNT ]; then
    echo "no files found"
elif [ "1" == $COUNT ]; then
    exec $EDITOR $FILE
else
    SELECTION=$(zenity --width=640 --height=480 --multiple --column=File --list $FILE | tr "|" " ")
    if [ -n "$SELECTION" ]; then
        exec $EDITOR $SELECTION
    fi
fi

