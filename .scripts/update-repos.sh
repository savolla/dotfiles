#!/usr/bin/env bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# @author : savolla
# @description: this script will update all my github repositories
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

### pushing to github
COMMIT_MESSAGE=$(curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s')

## github projects:
DOTFILES="$HOME/project/dev/dotfiles/.git"
# NOTITIA="$HOME/txt"
# BRAINDUMP="$HOME/txt/roam"

## dotfiles
git --git-dir="$DOTFILES" add -u
git --git-dir="$DOTFILES" commit -m "$COMMIT_MESSAGE"
git --git-dir="$DOTFILES" push -u origin main

## notitia
# cd "$NOTITIA"
# git add -u
# git add images/
# git add notitia/
# git commit -m "$COMMIT_MESSAGE"
# git push -u origin main

# ## braindump
# cd "$BRAINDUMP"
# git add *
# git commit -m "$COMMIT_MESSAGE"
# git push -u origin main
