#!/usr/bin/env bash

# Run this in the same working directory as the files

# Figure out which dirs to use
CONFIG=${XDG_CONFIG_HOME:-"~/.config"}
DATA=${XDG_DATA_HOME:-".local/share"}
STATE=${XDG_STATE_HOME:-".local/state"}

# Create the directories we'll use
# -p will make the parent directories as well and won't throw an error if they
# already exist.
mkdir -p "$CONFIG/zsh"
mkdir -p "$STATE/zsh"
mkdir -p "$CONFIG/nano"
mkdir -p "$CONFIG/neofetch"

# ln -sr: -r means relative links

ln -sr "$PWD/zshrc" "~/.zshrc"
ln -sr "$PWD/aliasrc" "$CONFIG/zsh/aliasrc"
ln -sr "$PWD/nanorc" "$CONFIG/nano/nanorc"
ln -sr "$PWD/machine-colours" "$CONFIG/zsh/machine-colours"
ln -sr "$PWD/neofetch_config.conf" "$CONFIG/neofetch/config.conf"
