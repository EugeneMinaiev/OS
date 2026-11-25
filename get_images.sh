#!/bin/bash

SERVER=$(echo "$1" | cut -d / -f 1-3)

curl -sS -f -L "$1" |                       
    tr '\n\t' '  ' |
    tr '<' '\n' |
    grep '^img' |
    sed -n 's/.* src="\([^"]*\)".*/\1/p' |
    sort -u |
    while read LINE
    do
        if echo "$LINE" | grep -E '^https?://' > /dev/null
        then
            curl -sS -f -L -O "$LINE"
        elif echo "$LINE" | grep '^/' > /dev/null
        then
            curl -sS -f -L -O "$SERVER$LINE"
        fi
    done
