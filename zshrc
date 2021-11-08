# Lines configured by zsh-newuser-install
HISTFILE=~/.local/state/zsh/history
HISTSIZE=50000
SAVEHIST=50000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/cactric/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Start of lines added by me!

# Ignore lines starting with a space in the history file
# KDE apps using the Konsole widget (like Dolphin and Kate) seem to expect this
setopt hist_ignore_space

# Correct commands
setopt correct

# Colours!
autoload -U colors && colors

# Export EDITOR variable
export EDITOR=nano
export VISUAL=nano

# Set the prompt
PS1="%B%{$fg[cyan]%}%M: %{$fg[green]%}%~%{$fg[yellow]%}$%{$reset_color%}%b "

# Greeting
hostname=$(hostname)
date=$(date)
greeting="\033[1m* You are $fg[yellow]${USER} $fg[white]on $fg[cyan]${hostname}$fg[white] using $fg[magenta]zsh$fg[white] ("
endofgreeting=")\033[0m"
echo -e $greeting$date$endofgreeting

# Complain if systemctl says the system is running
# E.g. “System is degraded! (see systemctl)” if a service failed
sysstatus=$(systemctl is-system-running)

if [ "$sysstatus" = running ]; then
    true
else
    echo -e "\033[1m$fg[red]System is $sysstatus! (see systemctl)\033[0m"
fi

unset greeting date endofgreeting sysstatus

# Load aliases and shortcuts from ~/.config/zsh
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

# Enable autocompletion
autoload -Uz compinit
compinit

# Autocompletion menu
zstyle ':completion:*' menu select

# Include hidden files
_comp_options+=(globdots)

# Load plugins. The paths differ on different distros
# zsh autosuggestions, package name is zsh-autosuggestions on Ubuntu and Arch
if [ -d "/usr/share/zsh/plugins" ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
   source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
   source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
   # Source Ubuntu's command not found handler as well
   source /etc/zsh_command_not_found
fi

# Add ~/.local/bin to the path
[ -d "$HOME/.local/bin" ] && PATH="$HOME.local/bin:$PATH"

# Some key bindings
# Ctrl-→
bindkey "[1;5C" forward-word
# Ctrl-←
bindkey "[1;5D" backward-word
# Ctrl-Backspace
bindkey "" backward-delete-word
# Ctrl-Delete
bindkey "[3;5~" delete-word
# Shift-Tab
bindkey "[Z" reverse-menu-complete
# Home
bindkey "[H" beginning-of-line
# End
bindkey "[F" end-of-line
# Insert
bindkey "[2~" overwrite-mode
# Delete
bindkey "[3~" delete-char
