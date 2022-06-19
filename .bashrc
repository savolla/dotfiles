#!/bin/bash

set -o vi

# Setting Bash prompt. Capitalizes username and host if root user (my root user uses this same config file).
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

export PROMT_COMMAND="clear"
export PATH="$PATH:$HOME/job/re/bin/:$HOME/.scripts/:$HOME/.emacs/bin/:$HOME/.scripts/process-cop:$HOME/bin/stm32cubeide:$HOME/.cargo/bin"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export QT_SCALE_FACTOR=0.7
export QT_QUICK_CONTROLS_MATERIAL_THEME="Dark"

# system maintenance
alias pis="pipenv shell"
alias pisi="pipenv install"
alias x="exit";
alias k="pkill -f"
alias progs="pacman -Qet" # List programs I've installed
alias orphans="pacman -Qdt" # List orphan programs
alias rmorph="sudo pacman -R \$(pacman -Qdtq)"
alias newnet="sudo systemctl restart NetworkManager" # Refresh wifi
alias rkey="sh ~/.scripts/repair-keys"
alias b="cd .."
alias g="cd"
alias psref="gpg-connect-agent RELOADAGENT /bye" # Refresh gpg
alias pss="pacman -Ss" # pacman search
alias ass="pacaur -Ss" # aur search
alias pi="sudo pacman -S --noconfirm" # pacman install
alias ai="pacaur -S" # aur install
alias prs="sudo pacman -Rs" # pacman remove
alias prf="sudo pacman -Rs" # pacman remove force
alias pause="process-pause.sh" # pause the process
alias cont="process-cont.sh" # continues the process
alias t="task" # taskwarrior!
alias vph="gmtool admin stop scratchphone || gmtool admin start scratchphone"


# some aliases
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME"
alias pee='pulseaudio-equalizer enable'
alias ped='pulseaudio-equalizer disable'
alias pes='pulseaudio-equalizer status'
alias jerry="sudo python ~/.scripts/i3-mouse.py"
alias f="clear"
alias yychr="wine ~/src/yychr-non-dotnet/yychr.exe 2>/dev/null &"
alias pg="ping gnu.org" # check the net
alias r="ranger"
alias mkdir="mkdir -pv"
weath() { curl wttr.in/$1 ;} # Check the weather (give city or leave blank).
alias torb="./src/tor-browser_en-US/Browser/start-tor-browser www.thepiratebay.org &"
alias win10-start="vboxmanage startvm win10"
alias win10-start="vboxmanage startvm win10"
alias win10-snap="vboxmanage snapshot win10 take"
alias win10-restore="vboxmanage snapshot win10 restore"


# adding color
alias ls='ls -hNl --color=auto --group-directories-first'
alias ll='ls -lhN --color=auto --group-directories-first'
alias la='ls -lhNa --color=auto --group-directories-first'
alias sl='ls -hNl --color=auto --group-directories-first'

alias grep="grep --color=always" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=xterm256" #Color cat - print file with syntax highlighting.


# Internet
alias video-dl="youtube-dl -cio '%(autonumber)s-%(title)s.%(ext)s'"
alias audio-dl="youtube-dl -xic --audio-quality 0 --audio-format \"mp3\""
alias site-dl="wget --random-wait -r -convert-links --html-extension -p -e robots=off -U mozilla"
alias ethspeed="speedometer -r enp3s0"
alias wifispeed="speedometer -r wlp2s0"
alias starwars="telnet towel.blinkenlights.nl"
alias tpbs="clear && figlet -c TPB Search && ~/.config/Scripts/tpb.sh" # Pirate Bay search
alias gp7="wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Arobas\ Music/Guitar\ Pro\ 7/GuitarPro7.exe"

# typos!
alias claer="clear"
alias clar="clear"
alias vim="nvim"

# Bash Completion
if [ -f /etc/bash_completion ]; then
	./etc/bash_completion
fi

# CPU speed adjust
alias fast="sudo cpupower frequency-set --max 3.5GHz"
alias normal="sudo cpupower frequency-set --max 2.7GHz"
alias slow="sudo cpupower frequency-set --max 800MHz"

alias xiaomi="ssh u0_a171@192.168.1.35 -p 8022"

# screen casting
alias screencast="ffmpeg -f alsa\
    -ac 2\
    -i pulse\
    -f x11grab\
    -r 60\
    -s 1920x1080\
    -i :0.0\
    -acodec pcm_s16le\
    -vcodec libx264\
    -preset ultrafast\
    -crf 0\
    -threads 0 output.mkv"


# python
alias create-python-environment="python -m venv --upgrade-deps ./venv"
alias activate-python-environment="chmod +x ./venv/bin/activate && source ./venv/bin/activate"
alias install-python-requirements="sudo pip install -r requirements.txt"
