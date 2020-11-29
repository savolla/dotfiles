# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# @author : savolla
# @description: this script will automatically generate and update my website
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#!/usr/bin/env bash
BLOG_PATH="$HOME/txt/blog"
BLOG="savolla.github.io"
GITHUB_PAGES="$HOME/dev/web/savolla.github.io"
COMMIT_MESSAGE=$(curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s')
GITHUB_USER=$(grep github ~/etc/sec/creds | awk -F : '{ print $3 }')
GITHUB_PASS=$(grep github ~/etc/sec/creds | awk -F : '{ print $4 }')

cd "$BLOG_PATH"
hugo -d "$GITHUB_PAGES"
# update my website
cd "$GITHUB_PAGES"
git add --all
git commit -m "$COMMIT_MESSAGE"
git push https://"$GITHUB_USER":"$GITHUB_PASS"@github.com/"$GITHUB_USER"/"$BLOG".git master
