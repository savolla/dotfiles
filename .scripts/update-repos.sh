# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# @author : savolla
# @description: this script will update all my github repositories
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#!/usr/bin/env bash

### pushing to github
GITHUB_USER=$(grep github ~/etc/sec/creds | awk -F : '{ print $3 }')
GITHUB_PASS=$(grep github ~/etc/sec/creds | awk -F : '{ print $4 }')
COMMIT_MESSAGE=$(curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s')

## github projects:
DOTFILES="$HOME/.dotfiles"
NOTITIA="$HOME/txt"

## dotfiles
git --git-dir="$DOTFILES" --work-tree="$HOME" add -u
git --git-dir="$DOTFILES" --work-tree="$HOME" commit -m "$COMMIT_MESSAGE"
git --git-dir="$DOTFILES" --work-tree="$HOME" push -u origin main

## notitia
cd "$NOTITIA"
git add -u
git commit -m "$COMMIT_MESSAGE"
git push -u origin main

## savolla.github.io
