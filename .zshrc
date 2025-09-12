# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh-history
HISTSIZE=4000
SAVEHIST=4000
KEYTIMEOUT=1
bindkey -v
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/savolla/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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
#alias emacs="~/.config/emacs/bin/doom run"
alias ncdu="gdu"
alias srm="secure-rm"
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# activate plugins
source "$HOME"/resource/repos/zsh-autosuggestions/zsh-autosuggestions.zsh
source "$HOME"/resource/repos/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# nix (single user install config)
if [ -e /home/savolla/.nix-profile/etc/profile.d/nix.sh ]; then . /home/savolla/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# start starship
eval "$(starship init zsh)"

# # nvm config
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
