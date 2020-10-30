#!/usr/bin/env bash

# Run this in the same working directory as the files

# Create the directories we'll use
# -p will make the parent directories as well and won't throw an error if they
# already exist.
mkdir -p ~/.config/zsh
mkdir -p ~/.config/nano

# ln -sr: -r means relative links

ln -sr $PWD/zshrc ~/.zshrc
ln -sr $PWD/aliasrc ~/.config/zsh/aliasrc
ln -sr $PWD/nanorc ~/.config/nano/nanorc
