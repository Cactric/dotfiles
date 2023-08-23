#!/usr/bin/env bash

# Run this in the same working directory as the files

# Figure out which dirs to use
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"
STATE="${XDG_STATE_HOME:-$HOME/.local/state}"
ZDOTDIR="${ZDOTDIR:-$HOME}" # Where to put .zshrc and the files zsh looks for. Set in /etc/zsh/zshenv if you want to change it

# Create the directories we'll use
# -p will make the parent directories as well and won't throw an error if they
# already exist.
mkdir -p "$CONFIG/zsh"
mkdir -p "$STATE/zsh"
mkdir -p "$CONFIG/nano"
mkdir -p "$CONFIG/neofetch"

# ln -sr: -r means relative links

ln -sr "$PWD/zshrc" "$ZDOTDIR/.zshrc"
ln -sr "$PWD/aliasrc" "$CONFIG/zsh/aliasrc"
ln -sr "$PWD/dircolors" "$CONFIG/zsh/dircolors"
ln -sr "$PWD/envrc" "$CONFIG/zsh/envrc"
ln -sr "$PWD/nanorc" "$CONFIG/nano/nanorc"
ln -sr "$PWD/machine-colours" "$CONFIG/zsh/machine-colours"
ln -sr "$PWD/neofetch_config.conf" "$CONFIG/neofetch/config.conf"
