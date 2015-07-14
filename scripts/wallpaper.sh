#!/bin/bash
##
# wallpaper.sh - generate a gnome wallpaper xml definition from images in a directory
# Created by Barry Attwater
##
##
# Useage: cd my-photos && ~/scripts/wallpaper.sh
##

if [ -f $PWD/baclground-1.xml ]
    then
        rm $PWD/background-1.xml
fi
declare -a array
list=$(ls)
c=0
for i in $list
    do
        array[c]=$i
        #echo $c+$i
        let c=$c+1
    done
echo "<background>
  <starttime>
    <year>2009</year>
    <month>08</month>
    <day>04</day>
    <hour>00</hour>
    <minute>00</minute>
    <second>00</second>
  </starttime>" > background-1.xml
for (( count=0; count<${#array[@]}; count++ ))
    do
        if [ "$count" -ne "0" ]
            then
                echo "    <to>$PWD/${array[count]}</to>
  </transition>" >> background-1.xml
        fi
        echo "  <static>
    <duration>1795.0</duration>
    <file>$PWD/${array[count]}</file>
  </static>" >> background-1.xml
        let lastcell=${#array[@]}-1
        if [ "$count" -lt "$lastcell" ]
            then
                echo "  <transition>
    <duration>5.0</duration>
    <from>$PWD/${array[count]}</from>" >> background-1.xml
        fi 
    done
echo "</background>" >> background-1.xml
