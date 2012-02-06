# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

eval $(keychain --eval -Q --quiet --noask id_rsa)

# Sets the console to vi mode
set -o vi

alias "gvim"="$HOME/bin/transparent_gvim"

export PATH="./bin:$HOME/bin:$PATH"

# Just to be explicit =)
export EDITOR="vim"
export COLORTERM="roxterm"

shopt -s dirspell
shopt -s globstar
bind Space:magic-space

function title() {
  echo -en "\033]2;$@\007"
}

function lazy_ssh() {
eval "alias \"$1\"=\"(ssh-add -l || ssh-add) 1>/dev/null; $1\""
}
lazy_ssh "ssh"
lazy_ssh "scp"
lazy_ssh "sshfs"
lazy_ssh "git"
