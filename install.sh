#!/usr/bin/env bash

# Run this in the same working directory as the files

# Create the directories we'll use
# -p will make the parent directories as well and won't throw an error if they
# already exist.
mkdir -p ~/.config/zsh
mkdir -p ~/.config/nano

# ln -rs: -r means relative links

ln -rs $PWD/zshrc ~/.zshrc
ln -rs $PWD/aliasrc ~/.config/zsh/aliasrc
ln -rs $PWD/nanorc ~/.config/nano/nanorc
