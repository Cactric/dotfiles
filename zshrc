# Lines configured by zsh-newuser-install
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/zsh/history
HISTSIZE=10100
SAVEHIST=10000
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
autoload -Uz add-zsh-hook

# Export EDITOR variable
export EDITOR=nano
export VISUAL=nano

# Load the machine colours
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/machine-colours"

# Set the prompt
PS1="%B%{%F{$HOSTNAME_COLOUR}%}%(2L.%M [%L].%M): %{%F{$PATH_COLOUR}%}%3~%{%F{$END_OF_PROMPT_COLOUR}%}$%f%b "

# Reverse prompt showing the time it took and the return code
function reset_rps1_precmd() {
  RPS1="%(?..%B%F{$RETURN_COLOUR} Returned %?%f%b )"
}

function timer_precmd() {
  if [ $timer ]; then
    local now=$(date +%s%3N)
    local d_ms=$(($now-$timer))
    local d_s=$((d_ms / 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))
    if ((h > 0)); then elapsed=${h}h${m}m
    elif ((m > 0)); then elapsed=${m}m${s}s
    elif ((s >= 5)); then elapsed=${s}s
    else unset timer; return
    fi
    
    RPS1="%F{$TIME_COLOUR}Took ${elapsed}%{$reset_color%}${RPS1}"
    unset timer
  fi
}

function timer_preexec() {
  timer=$(date +%s%3N)
}

add-zsh-hook -Uz precmd reset_rps1_precmd
add-zsh-hook -Uz precmd timer_precmd
add-zsh-hook -Uz preexec timer_preexec

#unset USERNAME_COLOUR HOSTNAME_COLOUR SHELLNAME_COLOUR PATH_COLOUR END_OF_PROMPT_COLOUR RETURN_COLOUR TIME_COLOUR

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

## Key bindings

# create a zkbd compatible hash
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
key[Control-Delete]="${terminfo[kDC5]}"

# Rebind the up/down keys for history search
[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Ctrl-→
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
# Ctrl-←
[[ -n "${key[Control-Left]}" ]] && bindkey -- "${key[Control-Left]}" backward-word
# Ctrl-Delete
[[ -n "${key[Control-Delete]}" ]] && bindkey -- "${key[Control-Delete]}" delete-word
# Shift-Tab
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
# Home
[[ -n "${key[Home]}" ]] && bindkey -- "${key[Home]}" beginning-of-line
# End
[[ -n "${key[End]}" ]] && bindkey -- "${key[End]}" end-of-line
# Insert
[[ -n "${key[Insert]}" ]] && bindkey -- "${key[Insert]}" overwrite-mode
# Delete
[[ -n "${key[Delete]}" ]] && bindkey -- "${key[Delete]}" delete-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Load environment variables from a script
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/envrc ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/envrc
fi

# Support a local zsh config that isn't tracked in git
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/localzshrc ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/localzshrc
fi
