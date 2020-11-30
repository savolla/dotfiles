# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# @author : savolla
# @description: this script will automatically generate and update my website
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#!/usr/bin/env bash
BLOG_PATH="$HOME/dev/web/blog"
BLOG_REPO="savolla.github.io"
GITHUB_PAGES="$HOME/dev/web/savolla.github.io"
COMMIT_MESSAGE=$(curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s')

# generate my blog
cd "$BLOG_PATH"
hugo -d "$GITHUB_PAGES"

# update my website
cd "$GITHUB_PAGES"
git add --all
git commit -m "$COMMIT_MESSAGE"
git push -u origin master
