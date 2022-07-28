#!/usr/bin/env bash

# Run this in the same working directory as the files

# Create the directories we'll use
# -p will make the parent directories as well and won't throw an error if they
# already exist.
mkdir -p ~/.config/zsh
mkdir -p ~/.local/state/zsh
mkdir -p ~/.config/nano
mkdir -p ~/.config/neofetch

# ln -sr: -r means relative links

ln -sr "$PWD/zshrc" ~/.zshrc
ln -sr "$PWD/aliasrc" ~/.config/zsh/aliasrc
ln -sr "$PWD/nanorc" ~/.config/nano/nanorc
ln -sr "$PWD/machine-colours" ~/.config/zsh/machine-colours
ln -sr "$PWD/neofetch_config.conf" ~/.config/neofetch/config.conf
