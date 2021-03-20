#!/usr/bin/env bash
set -euo pipefail

WEB_BROWSER="$(whereis brave | cut -d ' ' -f 2)"
SITES="translate\nprotonmail\nyoutube\ngitsearch\ngitprofile\nblog\nwikipedia\nhackernews\nlibgen\nzlibrary\nsearx\nstarpage\n"

CHOICE=$(echo -e $SITES | rofi -dmenu -p "goto: ")

case $CHOICE in
    translate)
        $WEB_BROWSER https://translate.google.com/ ;;
    protonmail)
        $WEB_BROWSER https://mail.protonmail.com/login ;;
    youtube)
        $WEB_BROWSER https://www.youtube.com/results ;;
    startpage)
        $WEB_BROWSER https://startpage.com/ ;;
    searx)
        $WEB_BROWSER https://searx.ir/ ;;
    gitprofile)
        $WEB_BROWSER https://github.com/savolla ;;
    gitsearch)
        $WEB_BROWSER https://github.com/search ;;
    blog)
        $WEB_BROWSER https://savolla.github.io/ ;;
    wikipedia)
        $WEB_BROWSER https://www.wikipedia.org/ ;;
    archwiki)
        $WEB_BROWSER https://wiki.archlinux.org/ ;;
    hackernews)
        $WEB_BROWSER https://news.ycombinator.com/ ;;
    libgen)
        $WEB_BROWSER http://libgen.rs/ ;;
    zlib)
        $WEB_BROWSER https://1lib.nl/ ;;
    *)
        echo -e $CHOICE | xsel -i
        notify-send "clipboard ready:\n$CHOICE"
        $WEB_BROWSER https://startpage.com/
        ;;
esac
