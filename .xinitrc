# # system setup
# setxkbmap tr & # set keyboard layout
# setxkbmap -option caps:swapescape & # swap esc with caps lock
# xrandr -s 1920x1080 & # set resolution
# unclutter -idle 2 & # disable mouse cursor
# xset r rate 150 50 &  # increase speed of keyboard
# xset s off & # disable screen saver
# xset -dpms & # disable monitor shutdown
# picom -b & # start compositor for opacity/fading stuff
# mpd & # start music server
# dunst & # start notification daemon
# sxhkd -m 1 & # keyboard shortcuts
# lxsession & # auth agent and other good stuff
# wpctl set-volume @DEFAULT_AUDIO_SINK@ 30% & # set pipewire volume to 30%
# periodic-random-wallpaper-switcher & # wallpaper service
# adaptive-blue-light-filter & # blue light filter
# tmux-session-creator & # launch cli programs in tmux
# sync-dotfiles-with-xkarna-usb & # daemon for synching and backing up config files to my thumb drive
# update-repos & # auto update repositories
# slstatus & # status bar
# opensnitchd & # application firewall
# opensnitch-ui --background & # for opensnitch interactive promts
# udiskie & # auto mount usb
#
# # auto start gui apps
# kitty -e attach-all-tmux-sessions &
# librewolf &
# logseq &
# ferdium &
# transmission-gtk &
#
# # start window manager
# exec dbus-run-session dwm
