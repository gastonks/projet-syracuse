#!/bin/sh

INTERVAL=0
re='^[0-9]+$'

if [ $# -eq 2 ]
then

    if [ -n "$1" ] && [ "$1" -eq "$1" ] && [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null;
    then
        #code ici
        echo both numbers
        
    else
        echo "Un des deux arguments n'est pas un nombre."
        exit 1
    fi
else
    echo "Il est necessaire d'avoir 2 arguments en entree."
    exit 1
fi