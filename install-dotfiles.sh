#!/bin/bash

# first install all the packages needed
sudo pacman -S unclutter -y
sudo pacman -S screenkey -y
sudo pacman -S flameshot -y
sudo pacman -S kitty -y
sudo pacman -S brave-browser -y
sudo pacman -S pavucontrol -y
sudo pacman -S rofi -y
sudo pacman -S emacs -y
sudo pacman -S ranger -y
sudo pacman -S sxiv -y
sudo pacman -S signal-desktop -y
sudo pacman -S retroarch -y
sudo pacman -S bat -y
sudo pacman -S pulseaudio-equalizer -y
sudo pacman -S xcalib -y
sudo pacman -S net-tools -y
sudo pacman -S ttf-fira-code -y
sudo pacman -S tmux -y
sudo pacman -S htop -y

# Place all contents inside .config
for dotfile in .config/*; do
    mv "$dotfile" "$USER"/.config
done

# place all single files in home
mv ./.doom.d ~/
mv ./.scripts ~/
mv ./.bashrc ~/
mv ./.dmenurc ~/
mv ./.gdbinit ~/
mv ./.profile ~/
mv ./.tmux.conf ~/
mv ./.tmux.conf ~/
