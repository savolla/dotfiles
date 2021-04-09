#!/usr/bin/env bash
set -euo pipefail

WEB_BROWSER="$(whereis brave | cut -d ' ' -f 2)"
SITES="archwiki\ntranslate\nprotonmail\nyoutube\ngitsearch\ngitprofile\nblog\nwikipedia\nhackernews\nlibgen\nzlib\nsearx\nstarpage\npiratebay\nuzem\ninvidious"

CHOICE=$(echo -e $SITES | rofi -dmenu -p "goto")

case $CHOICE in
    piratebay)
        $WEB_BROWSER https://thepiratebay.org/index.html ;;
    uzem)
        $WEB_BROWSER https://uzemders.duzce.edu.tr/ ;;
    translate)
        $WEB_BROWSER https://translate.google.com/ ;;
    protonmail)
        $WEB_BROWSER https://mail.protonmail.com/login ;;
    # youtube)
        # $WEB_BROWSER https://www.youtube.com/results ;;
    invidious)
        $WEB_BROWSER https://invidious.xyz/login?referer=%2F ;;
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
        $WEB_BROWSER https://1lib.net/ ;;
    *)
        # $WEB_BROWSER https://html.duckduckgo.com/html/
        # $WEB_BROWSER https://duckduckgo.com/?q="$CHOICE"&t=h_&ia=web
        $WEB_BROWSER https://swisscows.com/web?query="$CHOICE"&region=tr-TR
        ;;
esac
