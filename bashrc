# ~/.bashrc: executed by bash(1) for non-login shells.

export LANG='en_US.UTF-8'

# exports =============================================================
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$ '
export EDITOR=vim
export PYTHONSTARTUP=~/.pythonrc.py

export PATH="$PATH:/usr/local/bin"

if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$HOME/bin/tools:$PATH
fi

if [ -d $HOME/local ]; then
    export LOCAL="$HOME/local"
    #export LD_LIBRARY_PATH=$LOCAL/lib:$LD_LIBRARY_PATH
    #export CFLAGS="-I${LOCAL}/include $CFLAGS"
    #export LDFLAGS="-L${LOCAL}/lib $LDFLAGS"
    export PATH=$LOCAL/bin:$LOCAL/sbin:$PATH
fi

if [ -d $HOME/env ]; then
    export WORKON_HOME=~/env
    if [ -n "$LOCAL" ]; then
        source $LOCAL/bin/virtualenvwrapper.sh
    else
        source /usr/local/bin/virtualenvwrapper.sh
    fi
fi

if [ -d /usr/local/mysql/bin ]; then
    export PATH="$PATH:/usr/local/mysql/bin"
fi

# gentoo prefix
#export EPREFIX="/gentoo"
#export PATH="$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:$PATH"
#export CHOST="x86_64-apple-darwin10"

#android sdk
export PATH="/Applications/android-sdk-mac_x86/tools:$PATH"
export PATH="/Applications/android-sdk-mac_x86/platform-tools:$PATH"

# aliases =============================================================
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

alias ls='ls -G'

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

if [ `which tmux` ]; then
    alias s='tmux -2 attach -d -t'
    alias ss='tmux -2 ls'
    alias sn='tmux -2 new -s'
else
    alias s='screen -dRU'
    alias ss='screen -ls'
fi

alias v='vim -p'
alias crontab="VIM_CRONTAB=true crontab"

function purge {
    find . -name $1 -exec rm {} \;
}

# additional scripts =================================================
source ~/.extra/bash_completion_tmux.sh

# extras =============================================================
complete -cf sudo
