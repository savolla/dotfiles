#!/usr/bin/env bash
DELAY=0.5 # hours

# update github, my website and other things periodically
while true; do
        sleep $(echo "3600*$DELAY" | bc)
        ./update-my-life.sh  # run this script
    done
