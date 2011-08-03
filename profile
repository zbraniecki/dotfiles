# ~/.profile: executed by the command interpreter for login shells.
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

export PATH="$HOME/.local/bin:/opt/local/libexec/ccache:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH"
