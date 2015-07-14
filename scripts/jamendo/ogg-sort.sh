#! /bin/bash
##
# ogg-sort tool for using ogg-meta to move zip archives to paths for ogg files
# Copyright (c) 2012, Joseph Walton-Rivers <webpigeon@gmail.com>
#
# I designed this for jamendo zips, but you can use it for any zip file
# containing (oddly named) ogg files.
##
##
# WARNING
# This script will discard anything which is not an OGG file, you have been
# warned.
##

# Directory patten where we'll find the zips with the ogg files in
ZIP_DIR="/home/webpigeon/Downloads/jamendo/*Jamendo*.zip"

# Directory to serve as the base of the collection
NEW_BASE_PATH=`pwd`/music

# format for the new song titles
BASE_FORMAT="{artist}/{album}/{title}.ogg"

# Directory to extract to (will be deleted at the end)
TMP_DIR="/tmp/ogg-sort"

##
# CODE BELOW HERE - Don't edit if you don't know what you are doing.
##
shopt -s nullglob
for ZIP_NAME in $ZIP_DIR
do
    TMP_NAME=$TMP_DIR/`basename "$ZIP_NAME"`
    mkdir -p "$TMP_NAME"
    unzip -q "$ZIP_NAME" -d"$TMP_NAME"
    
    for OGG_NAME in "$TMP_NAME/"**.ogg
    do
        NEW_PATH=$NEW_BASE_PATH/`./ogg-meta --format $BASE_FORMAT "$OGG_NAME"`
        mkdir -p "`dirname "$NEW_PATH"`"
        mv "$OGG_NAME" "$NEW_PATH"
    done
    
    rm -r "$TMP_NAME"
done
rmdir $TMP_DIR
