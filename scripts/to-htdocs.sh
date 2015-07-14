#!/bin/bash
##
# to-htdocs - copy a folder to the lampp htdocs folder
# Created by Barry Attwater.
##

##
# Usage: ./to-htdocs.sh <folder-to-copy>
##

if [ -f $1 ]; then
    cp -u -v "$PWD/$1" "/opt/lampp/htdocs/$1"
else
    if [ ! -d "/opt/lampp/htdocs/$1" ]; then
        mkdir /opt/lampp/htdocs/$1
    fi
    cp -r -u -v "$PWD/$1/"* "/opt/lampp/htdocs/$1"
fi
