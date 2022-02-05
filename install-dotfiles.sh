#!/bin/bash

# first install all the packages needed
sudo pacman -S \
    unclutter \

# Place all contents inside .config
for dotfile in .config/*; do
    # cp -rva "$dotfile" ~/.config # hard copy
    cp -lRf "$dotfile" ~/.config/
done

# place all single files in home
cp -lRf .doom.d ~/
cp -lRf .scripts ~/
cp -lRf .bashrc ~/
cp -lRf .dmenurc ~/
cp -lRf .gdbinit ~/
cp -lRf .profile ~/
cp -lRf .tmux.conf ~/

echo "dotfiles are installed on the system"
