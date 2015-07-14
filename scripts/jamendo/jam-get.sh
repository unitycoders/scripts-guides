#! /usr/bin/env bash
CURR=`pwd`
cd ~/Downloads/jamendo
wget http://www.jamendo.com/get/album/id/album/archiverestricted/redirect/$1/?are=ogg3 --trust-server-names
cd $CURR
