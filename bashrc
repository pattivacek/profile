# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#if [ -n "${BASHRC_COMPLETE}" ]; then
#    return 0
#fi
#export BASHRC_COMPLETE=yes
#if [ ! -n "${PROFILE_COMPLETE}" ]; then
#    . ~/.profile
#fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ls="/bin/ls --color=tty"
alias la="ls -aF"
alias ll="ls -lhF --color=always"
alias lla="ll -a"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f /etc/bash_completion.d/git-prompt ]; then
   . /etc/bash_completion.d/git-prompt
   # Put the current git branch (if applicable) into our prompt
#   PS1='[\u@\h \t \W$(__git_ps1 " (%s)")]\$ '
   PS1='[$(date +%H%M)][\[\033[1;36m\]\u@\h:\w$(__git_ps1 " (%s)")\[\033[0m\]]$ '
else
#   PS1='[\u@\h \t \W]\$ '
   PS1='[$(date +%H%M)][\[\033[1;36m\]\u@\h:\w\[\033[0m\]]$ '
fi

#shortcuts
# The seds do syntax highlighting. -r is necessary for less to display that properly.
alias hl="sed 's/^-/\x1b[1;33m-/' | sed 's/^+/\x1b[31m+/' | sed 's/^\@/\x1b[36m@/' | sed 's/$/\x1b[0m/' | less -r"
# Vim less. If unavailable, try 'hl' to make the git/svn shortcuts prettier.
if [ -f /usr/share/vim/vim74/macros/less.sh ]; then
   alias lessv='/usr/share/vim/vim74/macros/less.sh'
elif [ -f /usr/share/vim/vim73/macros/less.sh ]; then
   alias lessv='/usr/share/vim/vim73/macros/less.sh'
elif [ -f /usr/share/vim/vim72/macros/less.sh ]; then
   alias lessv='/usr/share/vim/vim72/macros/less.sh'
elif [ -f /usr/share/vim/vim70/macros/less.sh ]; then
   alias lessv='/usr/share/vim/vim70/macros/less.sh'
else
   alias lessv='hl'
fi

# Git shortcuts.
alias glog="git log --name-status | lessv"
alias glogd="git log --name-status --decorate --color=always | hl"
alias glogorig="git log origin/master --name-status | lessv"
alias glogone="git log --oneline --decorate --color --graph --all"
alias gstat="git status"
alias gdiff="git diff -M | lessv"
alias gsdiff="git diff -M --staged | lessv"
# Hide whitespace changes.
alias gwdiff="git diff -M -w | lessv"
alias gswdiff="git diff -M --staged -w | lessv"
# Show explicit whitespace changes.
alias gadiff="git diff -M | cat -A | lessv"
alias gsadiff="git diff -M --staged | cat -A | lessv"

# SVN shortcuts.
alias svndiff="svn diff | lessv"
alias svnlog="svn log | lessv"
alias greps="grep --exclude=""*.svn*"""

# Ignore ctrl-s and ctrl-q, which normally halt terminal flow. Don't bother if
# this is a non-interactive shell.
if [ -t 0 ]; then
   stty -ixon -ixoff
fi

# Clean up gcc output. Not sure why *this* is the solution.
#unset LANG
# Try this to get umlauts displayed correctly:
#export LANG=de_DE.UTF-8
export LANG=en_US.UTF-8

# Use pretty colors with ls and other tools.
#eval "`dircolors -b ~/.dir_colors`"
