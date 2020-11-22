#!/bin/bash
okular "$(find ~/lib/* -type f -name '*.pdf' | awk -F "/" '{ print $NF }' | rofi -dmenu -i -p "Select Book: " | xargs find ~/lib/* -iname )"
