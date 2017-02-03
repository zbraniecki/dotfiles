# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# helper functions
source ~/.local/extra/utils.bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
shopt -s globstar

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
force_color_prompt=yes

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

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  (umask 066; /usr/bin/ssh-agent > "${SSH_ENV}")
  . "${SSH_ENV}" > /dev/null
}

export VCPROMPT_FORMAT=" (%b %u%%%m)"


bash_prompt() {
  local RESET=$(tput sgr0)
  local GREEN="\[\e[01;32m\]"
  local PURPLE="\[\e[01;35m\]"
  local ORANGE="\[\e[00;33m\]"

  function getsshstatus() {
    if [ $(id -u) != 0 ] && [[ $(ssh-add -l) != "The agent has no identities." ]]; then
        tput dim
        tput bold
    fi
  }

  PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u@\h\[$RESET\]:${PURPLE}\w${ORANGE}\$(vcprompt)\[$RESET\]\\[$(getsshstatus)\]\$ \[$RESET\]"
}

bash_prompt

unset bash_prompt

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
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

source ~/.local/extra/utils.bash

export EDITOR=nvim
export PYTHONSTARTUP=~/.local/pythonrc.py

if [ -d $HOME/.local/bin ]; then
  export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
fi

if [ -d $HOME/.local/env ]; then
  export WORKON_HOME=~/.local/env
  export VIRTUALENVWRAPPER_PYTHON=`which python`
  source_if_exists ~/.local/bin/virtualenvwrapper.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# aliases =============================================================
alias ls='ls -G'
alias grep='grep --color=auto'
alias mkve="mkvirtualenv --no-site-packages --python=/usr/bin/python3" 
alias mkve2="mkvirtualenv --no-site-packages --python=/usr/bin/python2.7" 
alias pmo="pastebin.py"

# git completion =====================================================
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
      start_agent;
  }
else
  start_agent;
fi

unset start_agent
