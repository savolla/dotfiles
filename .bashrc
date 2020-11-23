#/ ___|  __ ___   _____ | | | __ _   | |__   __ _ ___| |__  _ __ ___
#\___ \ / _` \ \ / / _ \| | |/ _` |  | '_ \ / _` / __| '_ \| '__/ __|
# ___) | (_| |\ V / (_) | | | (_| |  | |_) | (_| \__ \ | | | | | (__
#|____/ \__,_| \_/ \___/|_|_|\__,_|  |_.__/ \__,_|___/_| |_|_|  \___|

set -o vi
#stty -ixon

# For directory and config shortcuts:
# source ~/.bash_shortcuts

# Setting Bash prompt. Capitalizes username and host if root user (my root user uses this same config file).
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

export PROMT_COMMAND="clear"
export PATH=$PATH:$HOME/job/re/bin/:$HOME/.scripts/:$HOME/.emacs/bin/
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# generic shortcuts

o() { xdg-open "$@" & }
#rm(){
#    #if someone try to delete your root or home directory greet them
#    if [[ $1 == "-rf" || $1 == "-fr" && $2 == "/" ||  $2 == "~/" || $2 == "~" ]]; then
#        echo -e "just took your photo"
#    # elif [[ $1 == "-rf" || $1 == "-fr" || $1 == "*" && $2 == "." || $2 == "*"  ]]; then
#    elif [[ $1 == "-rf" || $1 == "-fr" || $1 == "*" ]]; then
#        echo -e "slow down cowboy.. really delete -> $(pwd) <- ?"
#        echo -e "[n/Y]"
#        read answer
#        if [[ $answer == "Y" ]]; then
#            $(which rm) -rf $(pwd)/* 
#        fi
#    fi
#    }

# system maintenance

alias x="exit";
alias k="pkill -f"
alias progs="pacman -Qet" # List programs I've installed
alias orphans="pacman -Qdt" # List orphan programs
alias rmorph="sudo pacman -R \$(pacman -Qdtq)"
alias newnet="sudo systemctl restart NetworkManager" # Refresh wifi
alias rkey="sh ~/.scripts/repair-keys"
alias b="cd .."
alias psref="gpg-connect-agent RELOADAGENT /bye" # Refresh gpg

# some aliases
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias pee='pulseaudio-equalizer enable'
alias ped='pulseaudio-equalizer disable'
alias pes='pulseaudio-equalizer status'
alias jerry="sudo python ~/.scripts/i3-mouse.py"
alias f="clear"
alias yychr="wine ~/src/yychr-non-dotnet/yychr.exe 2>/dev/null &"
alias pg="ping google.com" # check the net
alias r="ranger"
alias mkdir="mkdir -pv"
weath() { curl wttr.in/$1 ;} # Check the weather (give city or leave blank).
alias torb="./src/tor-browser_en-US/Browser/start-tor-browser www.thepiratebay.org &"

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias ll='ls -lhN --color=auto --group-directories-first'
alias lh='ls -lhNa --color=auto --group-directories-first'
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
#alias arduino="sudo sh ~/Tools/programs/arduino-1.8.8/arduino"
alias gp7="wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Arobas\ Music/Guitar\ Pro\ 7/GuitarPro7.exe"

# typos!
alias sl="ls"
alias l="ls"

# Bash Completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# virtual machine
alias win7="sudo qemu-system-x86_64 \
-enable-kvm \
-cpu host \
-smp sockets=1,cores=3,threads=2 \
-m 10G \
-rtc base=localtime,clock=host \
-drive file=~/wms/win7.img,format=raw \
-net nic,model=e1000 \
-net user \
-display sdl \
-usbdevice tablet\
"

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

ida()
{
    cd /home/savolla/.wine/drive_c/Program\ Files/IDA\ 7.0/
}
