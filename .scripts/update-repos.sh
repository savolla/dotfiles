#!/usr/bin/env bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# @author : savolla
# @description: this script will update all my github repositories
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

### pushing to github
COMMIT_MESSAGE=$(curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s')

## github projects:
DOTFILES="$HOME/project/dotfiles"
KARNA_TOOLKIT="$HOME/project/karna_toolkit"
BRAINDUMP="$HOME/project/braindump"

## dotfiles
echo "LOG: Entering dotfiles"
cd "$DOTFILES" || exit
git add --all
git commit -m "$COMMIT_MESSAGE"
git push -u origin main
echo "LOG: finished dotfiles"

## karna_toolkit
echo "LOG: Entering karna_toolkit"
cd "$KARNA_TOOLKIT" || exit
git add --all
git commit -m "$COMMIT_MESSAGE"
git push -u origin main
echo "LOG: finished karna_toolkit"

## braindump
echo "LOG: Entering braindump"
cd "$BRAINDUMP" || exit
git add --all
git commit -m "$COMMIT_MESSAGE"
git push -u origin main
echo "LOG: finished braindump"
