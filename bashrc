# helper functions
source ~/.local/extra/utils.bash

export LANG='en_US.UTF-8'

# exports =============================================================
export EDITOR=vim
export PYTHONSTARTUP=~/.local/pythonrc.py

export PATH="$HOME/.local/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH"

if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

if [ -d $HOME/.local/env ]; then
    export WORKON_HOME=~/.local/env
    source_if_exists /usr/local/bin/virtualenvwrapper.sh
fi

# aliases =============================================================
alias ls='ls -G'
alias grep='grep --color=auto'
alias mkve="mkvirtualenv --no-site-packages" 

# additional scripts =================================================
source ~/.local/extra/git-completion.bash
source ~/.local/extra/git-flow-completion.bash

# git completion =====================================================
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
