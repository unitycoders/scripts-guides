#! /bin/bash
##
# ogg-sort tool for using ogg-meta to print correct paths for ogg files
# Copyright (c) 2012, Joseph Walton-Rivers <webpigeon@gmail.com>
#
# As this is research it just prints out what the path would be,
# it doesn't attually move them.
##

BASE_PATH=`pwd`
NEW_BASE_PATH=`pwd`
BASE_FORMAT="{artist}/{album}/{title}.ogg"


for OGG_NAME in $BASE_PATH/**.ogg
do
    NEW_PATH=$NEW_BASE_PATH/`./ogg-meta --format $BASE_FORMAT $OGG_NAME`
    echo $OGG_NAME to $NEW_PATH
done
