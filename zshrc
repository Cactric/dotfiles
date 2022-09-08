# Lines configured by zsh-newuser-install
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/zsh/history
HISTSIZE=50000
SAVEHIST=50000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}"/zcompdump-$ZSH_VERSION
# End of lines added by compinstall

# Start of lines added by me!

# Ignore lines starting with a space in the history file
# KDE apps using the Konsole widget (like Dolphin and Kate) seem to expect this
setopt hist_ignore_space

# Replace duplicates in the history file
setopt histignorealldups
# Correct commands
setopt correct

# Colours!
autoload -U colors && colors

# Export EDITOR variable
export EDITOR=nano
export VISUAL=nano

# Load the machine colours
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/machine-colours"

# Set the prompt
PS1="%B%{%F{$HOSTNAME_COLOUR}%}%M: %{%F{$PATH_COLOUR}%}%~%{%F{$END_OF_PROMPT_COLOUR}%}$%f%b "
RPS1="%(?..%B%F{$RETURN_COLOUR} Returned %?%f%b )"
# Greeting
hostname="$HOST" # in bash, this would be $HOSTNAME
                 # not that that matters for a .zshrc
date=$(date)
greeting="\033[1m$fg[white]* You are $fg[$USERNAME_COLOUR]${USER} $fg[white]on $fg[$HOSTNAME_COLOUR]${hostname}$fg[white] using $fg[$SHELLNAME_COLOUR]zsh$fg[white] ("
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
unset USERNAME_COLOUR HOSTNAME_COLOUR SHELLNAME_COLOUR PATH_COLOUR END_OF_PROMPT_COLOUR RETURN_COLOUR


# Load aliases and shortcuts from ~/.config/zsh
ALIASRC="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"
[ -f "$ALIASRC" ] && source "$ALIASRC"

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
   if [ -f "/etc/zsh_command_not_found" ]; then
       source /etc/zsh_command_not_found
   fi
fi

# Make the up key search through history with what was already written
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Rebind the up/down keys for it
bindkey "[A" up-line-or-beginning-search
bindkey "[B" down-line-or-beginning-search


# Add ~/.local/bin to the path
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

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

# Force silly programs to support XDG base directories instead of littering ~
export NPM_CONFIG_USERCONFIG="${XDG_DATA_HOME:-$HOME/.local/share}/npm/npmrc"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GRADLE_USER_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/gradle
export STACK_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}"/stack
export GHCUP_USE_XDG_DIRS=1

# Support a local zsh config that isn't tracked in git
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/localzshrc ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/localzshrc
fi
