#!/usr/bin/env bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# @author : savolla
# @description: this script will update all my github repositories
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

### pushing to github
COMMIT_MESSAGE=$(curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s')

## github projects:
DOTFILES="$HOME/project/dotfiles"
NOTITIA="$HOME/project/notitia"
KARNA_TOOLKIT="$HOME/project/karna_toolkit"
# BRAINDUMP="$HOME/txt/roam"

## dotfiles
echo "LOG: Entering dotfiles"
cd "$DOTFILES" || exit
git add --all
git commit -m "$COMMIT_MESSAGE"
git push -u origin main
echo "LOG: finished dotfiles"

## notitia
echo "LOG: Entering notitia"
cd "$NOTITIA" || exit
git add -u
git add images/
git add notitia/
git commit -m "$COMMIT_MESSAGE"
git push -u origin main
echo "LOG: finished notitia"

## karna_toolkit
echo "LOG: Entering karna_toolkit"
cd "$KARNA_TOOLKIT" || exit
git add --all
git commit -m "$COMMIT_MESSAGE"
git push -u origin main
echo "LOG: finished karna_toolkit"

# ## braindump
# cd "$BRAINDUMP"
# git add *
# git commit -m "$COMMIT_MESSAGE"
# git push -u origin main
