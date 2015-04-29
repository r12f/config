######################################################################
#
# r12f's bashrc (https://github.com/r12f/config)
# email: r12f.code@gmail.com
#
# The bashrc contains several sections:
# 0. Environment settings
# 1. Basic
# 2. File and directory control
# 3. Process control
# 4. Text manipulation
#
######################################################################

######################################################################
#
# 0. Environment settings
#
######################################################################
# Color definitions for output
export COLOR_NORMAL="\[\e[0m\]"
export COLOR_RED="\[\e[31m\]"
export COLOR_GREEN="\[\e[32m\]"
export COLOR_YELLOW="\[\e[33m\]"
export COLOR_BLUE="\[\e[36m\]"

# Command line prompt
export PS1="${COLOR_BLUE}\u${COLOR_NORMAL}@${COLOR_GREEN}\h:${COLOR_YELLOW}\w${COLOR_NORMAL}\n\$ "
export PS2="\$ "

# Useful Environments
OS_NAME=`uname`

IS_BUSYBOX=0
if busybox >/dev/null 2>&1; then
    IS_BUSYBOX=1
fi

# Set default editor
if which "gvim" >/dev/null 2>&1; then
    export MY_EDITOR=gvim
elif which "mvim" >/dev/null 2>&1; then
    export MY_EDITOR=mvim
else
    export MY_EDITOR=vim
fi

if [[ "$OS_NAME" == "Darwin" ]]; then
    export CLICOLOR=1                       # ls color setting
    export LSCOLORS=ExFxBxDxCxegedabagacad  # ls color setting
fi

# Path
alias path='echo -e ${PATH//:/\\n}'         # Show all paths

######################################################################
#
# 1. Basic terminal commands
#
######################################################################
alias c='clear'

######################################################################
#
# 2. File and directory control
#
######################################################################
alias e="$MY_EDITOR"                           # Open in default editor

if [[ "$OS_NAME" == "Darwin" ]]; then
    alias f="open -a Finder ./"             # Open current folder in Finder
    alias ls="ls -GFh"                      # List files with color and human-readable output
elif (( $IS_BUSYBOX == 0 )); then           # Busybox runs on linux but don't have colored output
    alias ls="ls --color=auto -h"           # List files with color and human-readable output
fi

alias ll="ls -l"                            # List files in list
alias la="ls -a"                            # List all files in list style
alias lla="ls -la"                          # List all files in list style
alias l="lla"                               # Preferred ls format
alias dir="lla"                             # For DOS style

alias cd..="cd ../"                         # Go to parent directory (for DOS style)
alias ..="cd ../"                           # Go up to parent directory
alias ...="cd ../../"                       # Go up 2 times
alias .3="cd ../../../"                     # Go up 3 times
alias .4="cd ../../../../"                  # Go up 4 times
alias .5="cd ../../../../../"               # Go up 5 times
alias .6="cd ../../../../../../"            # Go up 6 times
alias ~="cd ~"                              # Go to home directory

alias mv="mv -iv"                           # Move files with confirming and verbose
alias cp="cp -iv"                           # Copy files with confirming and verbose

trash() { mv "$@" ~/.Trash; }               # Move files to trash

alias fn="find ./ -name"                    # Search files in current folder

# Extract files
extract () {
    if [ ! -f "$1" ]; then
        echo "Error: \"$1\" is not a valid file"
        return
    fi

    case "$1" in
        *.zip)      unzip "$1"       ;;
        *.rar)      unrar e "$1"     ;;
        *.7z)       7z x "$1"        ;;
        *.tar)      tar xf "$1"      ;;
        *.gz)       gunzip "$1"      ;;
        *.tgz)      tar xzf "$1"     ;;
        *.tar.gz)   tar xzf "$1"     ;;
        *.tar.bz2)  tar xjf "$1"     ;;
        *.tbz2)     tar xjf "$1"     ;;
        *)          echo "Error: Unknown file type: \"$1\"" ;;
    esac
}

######################################################################
#
# 3. Process control
#
######################################################################
p() { ps "$@" -o user,pid,%cpu,%mem,start,time,command;  }      # Default process output format
alias pa="p ax"                                                 # List all processes
alias pu="p -U"                                                 # List processes of certain user
alias pme="pu $USER"                                            # List my processes

######################################################################
#
# 4. Text manipulation
#
######################################################################
if (( $IS_BUSYBOX == 0 )); then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

######################################################################
#
# 5. Others
#
######################################################################
# Some settings are different on each machine, so we load local environment here.
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
