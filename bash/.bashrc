######################################################################
#
# r12f's bashrc (https://github.com/r12f/config)
# email: r12f.code@gmail.com
#
######################################################################

######################################################################
#
# 0. Shell settings
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

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Setting history length.
# see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Load all aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

######################################################################
#
# 1. Others
#
######################################################################
# Ansible local password file
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass
export ANSIBLE_VAULT_FILE=

# Add user bin folder for go
if [ -d "/usr/local/bin/go" ]; then
  export PATH="$PATH:/usr/local/bin/go/bin"

  if [ -d "$HOME/go/bin" ]; then
    export PATH="$PATH:$HOME/go/bin"
  fi
fi

# Wasmtime environment
if [ -d "$HOME/.wasmtime" ]; then
  export WASMTIME_HOME="$HOME/.wasmtime"
  export PATH="$WASMTIME_HOME/bin:$PATH"
fi

# Rust
if [ -d "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
fi

# User bin
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# SONiC build environment
export NOJESSIE=1
export NOSTRETCH=1
export NOBUSTER=1
export SONIC_BUILD_JOBS=24

######################################################################
#
# x. Local overrides
#
######################################################################
# Some settings are different on each machine, so we load local environment here.
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
