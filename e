#!/bin/bash

if [ -z "$1" ]; then
    exec vs
fi

FILE=$(find . -name "$1" | sort)
FILES=( $FILE )
COUNT=${#FILES[@]}

if [ "0" == $COUNT ]; then
    echo "no files found"
elif [ "1" == $COUNT ]; then
    exec vs $FILE
else
    SELECTION=$(zenity --width=640 --height=480 --multiple --column=File --list $FILE | tr "|" " ")
    if [ -n "$SELECTION" ]; then
        exec vs $SELECTION
    fi
fi

