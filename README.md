# dotfiles

List of files included, and where they should go:
./install.sh should automatically create symbolic links to the intended 
destinations from the files in this repo

(source, in this repo → destination, in file system)

* zshrc → ~/.zshrc
    * This zshrc will create ~/.local/state/zsh/history
    * This zshrc has some dependencies, see the file for details
* aliasrc → ~/.config/zsh/aliasrc
* envrc → ~/.config/zsh/envrc
* nanorc → ~/.config/nano/nanorc
* machine-colours → ~/.config/zsh/machine-colours
* dircolors → ~/.config/zsh/dircolors
* neofetch_config.conf → ~/.config/neofetch/config.conf

* _if `XDG_CONFIG_HOME` is set, anything I said goes in `~/.config` goes there instead_
* _if `XDG_STATE_HOME` is set, the history files goes there instead of `~/.local/state`_

