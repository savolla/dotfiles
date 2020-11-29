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
DOTFILES=".dotfiles"
NOTITIA="txt"

## dotfiles
git --git-dir="$HOME/$DOTFILES" --work-tree="$HOME" add -u
git --git-dir="$HOME/$DOTFILES" --work-tree="$HOME" commit -m "$COMMIT_MESSAGE"
git --git-dir="$HOME/$DOTFILES" --work-tree="$HOME" push https://"$GITHUB_USER":"$GITHUB_PASS"@github.com/"$GITHUB_USER"/dotfiles.git main -f

## notitia
git --git-dir="$HOME/$NOTITIA"/.git add -u
git --git-dir="$HOME/$NOTITIA"/.git commit -m "$COMMIT_MESSAGE"
git --git-dir="$HOME/$NOTITIA"/.git push https://"$GITHUB_USER":"$GITHUB_PASS"@github.com/"$GITHUB_USER"/"$NOTITIA".git main -f

## savolla.github.io
