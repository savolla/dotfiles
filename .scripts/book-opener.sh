#!/bin/bash
READER="zathura"
$READER "$(find ~/lib/* -type f -name '*.pdf' -o -name '*.epub' \
 | awk -F "/" '{ print $NF }' \
 | rofi -dmenu -i -p "Select Book: " \
 | xargs -d'\n' find ~/lib/* -iname )"
