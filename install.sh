#!/usr/bin/env bash

#Run this in the same working directory as the files
#ln -rs: -r means relative links

ln -rs $PWD/zshrc ~/.zshrc
ln -rs $PWD/aliasrc ~/.config/zsh/aliasrc
ln -rs $PWD/nanorc ~/.config/nano/nanorc
