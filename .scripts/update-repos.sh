#!/usr/bin/env bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# @author : savolla
# @description: this script will update all my github repositories
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

### pushing to github
COMMIT_MESSAGE=$(curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s')

## github projects:
DOTFILES="$HOME/.dotfiles"
NOTITIA="$HOME/txt"

## dotfiles
cd $DOTFILES
git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME add -u
git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME commit -m "$COMMIT_MESSAGE"
git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME push -u origin wsl2

## notitia
cd "$NOTITIA"
git add -u
git add images
git commit -m "$COMMIT_MESSAGE"
git push -u origin main
