#!/usr/bin/env bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# @author : savolla
# @description: this script will update all my github repositories
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

### pushing to github
COMMIT_MESSAGE=$(curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s')

## github projects:
DOTFILES="$HOME/project/dotfiles"
NOTITIA="$HOME/project/notitia/.git/"
# BRAINDUMP="$HOME/txt/roam"

## dotfiles
cd "$DOTFILES"
git add -u
git commit -m "$COMMIT_MESSAGE"
git push -u origin main

## notitia
cd "$NOTITIA"
git add -u
git add images/
git add notitia/
git commit -m "$COMMIT_MESSAGE"
git push -u origin main

# ## braindump
# cd "$BRAINDUMP"
# git add *
# git commit -m "$COMMIT_MESSAGE"
# git push -u origin main
