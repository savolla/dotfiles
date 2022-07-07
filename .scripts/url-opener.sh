#!/usr/bin/env bash
set -euo pipefail

WEB_BROWSER="$(whereis firefox | cut -d ' ' -f 2)"
SITES="bookstack\ngithub\nheadphones\nirc\ncloud\nmusic\ntodo\narchwiki\nrss\nwsearch\nportainer\nsearch\ndashboard\ntranslate\nprotonmail\ndiscord\nyoutube\ngitsearch\ngitprofile\nblog\nwikipedia\nhackernews\nlibgen\nzlib\nsearx\nstarpage\npiratebay\nuzem\ninvidious\nnews\nwrss\nwportainer\nwheimdall\nwsearch\nwcloud\nwirc\n"

CHOICE=$(echo -e $SITES | rofi -dmenu -p "goto")

case $CHOICE in
    # savolla's portainer apps
    rss)
        $WEB_BROWSER "http://192.168.1.194:10000/i/" ;;
    dashboard)
        $WEB_BROWSER "http://192.168.1.194" ;;
    search)
        $WEB_BROWSER "http://192.168.1.194:5000/" ;;
    portainer)
        $WEB_BROWSER "https://192.168.1.194:9000/#!/home" ;;
    irc)
        $WEB_BROWSER "http://192.168.1.194:64080" ;;
    cloud)
        $WEB_BROWSER "https://192.168.1.194:10101" ;;
    todo)
        $WEB_BROWSER "http://192.168.1.194:10016" ;;
    music)
        $WEB_BROWSER "http://192.168.1.194:10016" ;;
    headphones)
        $WEB_BROWSER "http://192.168.1.194:10016" ;;
    github)
        $WEB_BROWSER "http://192.168.1.194:3000" ;;
    bookstack)
        $WEB_BROWSER "http://192.168.1.194:6876" ;;

    # work shortcuts
    wrss)
        $WEB_BROWSER "http://192.168.68.194:10000/i/" ;;
    wdashboard)
        $WEB_BROWSER "http://192.168.68.194:81" ;;
    wsearch)
        $WEB_BROWSER "http://192.168.68.194:5000/" ;;
    wportainer)
        $WEB_BROWSER "http://192.168.68.194:9443/#!/home" ;;
    wcloud)
        $WEB_BROWSER "https://192.168.68.194:10101/" ;;
    wirc)
        $WEB_BROWSER "http://192.168.68.194:64081/" ;;


    piratebay)
        $WEB_BROWSER "https://thepiratebay.org/index.html" ;;
    discord)
        $WEB_BROWSER "https://discord.com/login" ;;
    uzem)
        $WEB_BROWSER "https://uzemders.duzce.edu.tr/" ;;
    translate)
        $WEB_BROWSER "https://libretranslate.com/" ;;
    protonmail)
        $WEB_BROWSER "https://mail.protonmail.com/login" ;;
     youtube)
        $WEB_BROWSER "https://yewtu.be" ;;
    startpage)
        $WEB_BROWSER "https://startpage.com/" ;;
    searx)
        $WEB_BROWSER "https://searx.ir/" ;;
    gitprofile)
        $WEB_BROWSER "https://github.com/savolla" ;;
    gitsearch)
        $WEB_BROWSER "https://github.com/search" ;;
    blog)
        $WEB_BROWSER "https://savolla.github.io/" ;;
    wikipedia)
        $WEB_BROWSER "https://www.wikipedia.org/" ;;
    archwiki)
        $WEB_BROWSER "https://wiki.archlinux.org/" ;;
    hackernews)
        $WEB_BROWSER "https://news.ycombinator.com/" ;;
    libgen)
        $WEB_BROWSER "http://libgen.rs/" ;;
    zlib)
        $WEB_BROWSER "https://1lib.net/" ;;
    news)
        $WEB_BROWSER "https://newslookup.com/results?ovs=&dp=&mt=-1&mtx=0&tp=&s=&groupby=no&cat=-1&fmt=&ut=&mkt=0&mktx=0&q=turkey&m=" ;;
    *)
        $WEB_BROWSER https://html.duckduckgo.com/html/?q="$CHOICE"&t=h_&ia=web
        # $WEB_BROWSER https://duckduckgo.com/?q="$CHOICE"&t=h_&ia=web
        # $WEB_BROWSER https://swisscows.com/web?query="$CHOICE"&region=tr-TR
        ;;
esac
