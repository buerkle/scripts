#!/bin/bash

EDITOR=${EDITOR:-vs}
WM_CLASS=${WM_CLASS:-SlickEdit}

f () {
    FILE=$(find -L . -type d -name .git -prune -o -type f -not -name "*.class" -not -name "*.pyc" -iname "$1" -print | sort) 
    FILES=( $FILE )
    COUNT=${#FILES[@]}
}

run_editor () {
    if [ "$DESKTOP_SESSION" = "i3" ]; then
        i3-msg "[class=$WM_CLASS] focus" > /dev/null
    fi
    exec $EDITOR "$1"
}

if [ -z "$1" ]; then
    run_editor
fi

if [ "-c" = "$1" ]; then
    run_editor "$2"
fi

if [ -f "$1" ]; then
    run_editor "$@"
fi

f "$1*"

if [ "0" == $COUNT ]; then
    echo "no files found"
elif [ "1" == $COUNT ]; then
    run_editor $FILE
else
    SELECTION=$(zenity --width=640 --height=480 --multiple --column=File --list $FILE | cut -d'|' -f2)
    if [ -n "$SELECTION" ]; then
        run_editor $SELECTION
    fi
fi

