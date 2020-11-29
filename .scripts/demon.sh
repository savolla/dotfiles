#!/usr/bin/env bash
PERIOD=1 # hours
DELAY=$(echo "3600*$DELAY" | bc)

# update github, my website and other things periodically
while true; do
        sleep "$DELAY"
        ./update-repos.sh   # update all github repos
        ./update-blog.sh    # update my blog
    done
