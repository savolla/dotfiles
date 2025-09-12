#!/usr/bin/env bash

set -o vi
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# aliases
alias r="ranger"
alias f="clear"
alias clar="clear"
alias cler="clear"
alias claer="clear"
alias x="exit"
alias b="cd .."
alias pg="ping gnu.org"
alias sxiv="nsxiv"
alias ls="exa"
alias emacs="~/.config/emacs/bin/doom run"

# export PATH=$HOME/project/scripts/linux/:$PATH

# start starship
# eval "$(starship init bash)"
