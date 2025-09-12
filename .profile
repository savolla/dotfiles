#!/usr/bin/env sh

# set your user specific environment variables here

# path
export PATH="$HOME"/project/scripts/linux:"$PATH" # personal scripts
export PATH="$HOME"/.config/emacs/bin:"$PATH"     # doom emacs binaries

# doom emacs
export DOOMDIR="$HOME"/.config/doom
export EMACSDIR="$HOME"/.config/emacs

# tools
export EDITOR="nvim"
export FILE_BROWSER="pcmanfm"
export DISK_UTILITY="gparted"
export TERMINAL="kitty"
export APP_LAUNCHER="dmenu_run"
export BROWSER="librewolf"
export IMAGE_VIEWER="nsxiv"

# dirs
export APPIMAGE_DIR="$HOME/resource/tools/appimages"
export REPO_DIR="$HOME/resource/repos"
export SCRIPTS_DIR="$HOME/project/scripts/linux"
export WALLPAPER_DIR="$HOME/resource/images/wallpapers"

# files
export LOG_FILE="/tmp/sxhkd-program-logs"
export ICONS_DIR="$HOME/resource/images/icons"

# locale
export LANG="en_US.UTF-8"
export LC_ADDRESS="tr_TR.UTF-8"
export LC_IDENTIFICATION="tr_TR.UTF-8"
export LC_MEASUREMENT="tr_TR.UTF-8"
export LC_MONETARY="tr_TR.UTF-8"
export LC_NAME="tr_TR.UTF-8"
export LC_NUMERIC="tr_TR.UTF-8"
export LC_PAPER="tr_TR.UTF-8"
export LC_TELEPHONE="tr_TR.UTF-8"
export LC_TIME="tr_TR.UTF-8"

# theme
export GTK_THEME=Adwaita:dark

# application specific
# export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
# export PYTHONPATH="$HOME/python_modules"
# export NODE_ENV="production"
# export GOPATH="/home/user/go"
export LIBVIRT_DEFAULT_URI=qemu:///system

# redshift
export LOCATION_LATITUDE="40.698560"
export LOCATION_LONGITUDE="29.877012"
export TEMP_DAY="5700"
export TEMP_NIGHT="3200"

# ncurses
export TERM=linux

# ollama
export OLLAMA_MODELS="$HOME/resource/ai/llm/ollama/models"
export OLLAMA_HOME="$HOME/resource/ai/llm/ollama/home"

# ryujinx fork appimage
# export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 # don't enable it bcuz settings will not be opened. crash

# hardware
export MAC_SONY_EARBUDS="74:45:CE:31:EF.4C"
export MAC_PS4_CONTROLLER="D0:BC:C1:ED:AC:3D"
export MAC_JBL_GO="28:FA:19:6C:C9:05"
export MAC_KEYCHRON_K3_KEYBOARD="DC:2C:26:00:4D:E6"

# android
# export ANDROID_HOME="$HOME/resource/sdk/android" # android sdk directory. expo dev build requires it
# export PATH="$PATH:$ANDROID_HOME/cmdline-tools/19.0" # adb binary etc.
# export PATH="$PATH:$ANDROID_HOME/cmdline-tools/19.0/bin"
# export PATH="$PATH:$ANDROID_HOME/platform-tools"
# export PATH="$PATH:$ANDROID_HOME/emulator" # android emulator binaries
export ANDROID_SDK_ROOT="$HOME/resource/sdk/android"
export ANDROID_HOME="$HOME/resource/sdk/android" # Deprecated, but some programs still using it to locate SDK
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin/:$PATH"
export PATH="$ANDROID_HOME/platform-tools/:$PATH"
export PATH="$ANDROID_HOME/emulator/:$PATH"
# export EDGE_PATH="$(which chromium-browser)" # react-dev tools / debugger

if [ -e /home/savolla/.nix-profile/etc/profile.d/nix.sh ]; then . /home/savolla/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
