#!/bin/bash
# FIXME: this script is not working

# This script shows all i3-wm keybindings on a terminal

function displayKeybindings {
    return "$(grep "^bindsym" /home/"$USER"/.config/i3/config | \
    sed "s/$mod2/ALT/" | \
    sed "s/$mod/WIN/" | \
    sed "s/bindsym//" | \
    sed "s/exec //" | \
    sed "s/--no-startup-id //" | \
    sed "s/#.*$//" | \
    sed "s/--release //g" | \
    sort)"
}

output=$(displayKeybindings)
echo $output
