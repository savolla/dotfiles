#!/bin/bash
READER="zathura"
LIB_PATH="/mnt/c/Users/savolla/Desktop/savolla/lib"
$READER "$(find $LIB_PATH/* -type f -name '*.pdf' -o -name '*.epub' \
 | awk -F "/" '{ print $NF }' \
 | rofi -dmenu -i -p "Select Book: " \
 | xargs -d'\n' find $LIB_PATH/* -iname )"
