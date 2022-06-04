#!/usr/bin/env bash

CURRENT_HOUR=$(date "+%T" | awk -F ":" '{ print $1 }')
HALF_OF_AN_HOUR=$((30*60))
while true
do

    sleep $HALF_OF_AN_HOUR
done
