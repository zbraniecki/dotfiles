# ~/.profile: executed by the command interpreter for login shells.
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

export PATH="$HOME/.local/bin:/opt/local/libexec/ccache:/Library/Frameworks/Python.framework/Versions/3.3/bin:/usr/local/bin:$PATH"

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=
