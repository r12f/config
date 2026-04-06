######################################################################
#
# r12f's zshrc (https://github.com/r12f/config)
# email: r12f.code@gmail.com
#
######################################################################

######################################################################
#
# 0. Shell settings
#
######################################################################

# Command line prompt (matching bash: cyan user @ green host : yellow path)
export PS1="%F{cyan}%n%f@%F{green}%m:%F{yellow}%~%f
$ "

# Useful Environments
OS_NAME=$(uname)

# Set default editor
if which "gvim" >/dev/null 2>&1; then
    export MY_EDITOR=gvim
elif which "mvim" >/dev/null 2>&1; then
    export MY_EDITOR=mvim
else
    export MY_EDITOR=vim
fi

if [[ "$OS_NAME" == "Darwin" ]]; then
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
fi

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# Enable completion
autoload -Uz compinit && compinit

# Load all aliases
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

######################################################################
#
# 1. Path
#
######################################################################

# Some embedded systems don't have */sbin in PATH, so we add it here.
if [[ ! $PATH =~ "/sbin" ]]; then
  export PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin"
fi

# Homebrew
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add user bin folder for go
if [ -d "/usr/local/bin/go" ]; then
  export PATH="$PATH:/usr/local/bin/go/bin"
fi
if [ -d "$HOME/go/bin" ]; then
  export PATH="$PATH:$HOME/go/bin"
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

# NPM
if [ -d "$HOME/.npm-global" ]; then
  export PATH="$HOME/.npm-global/bin:$PATH"
fi

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Esp32
if [ -f "$HOME/export-esp.sh" ]; then
  . "$HOME/export-esp.sh"
fi

# User bin
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

######################################################################
#
# 2. Ansible
#
######################################################################

export ANSIBLE_INVENTORY="-i ~/.ansible_inventory"
export ANSIBLE_VAULT_FILE="~/.ansible_vault.yaml"
export ANSIBLE_VAULT_PASSWORD_FILE="~/.ansible_vault_pass"

######################################################################
#
# x. Others
#
######################################################################

export GITHUB_USER=$USER

# SONiC build environment
export NOBULLSEYE=1
export NOJESSIE=1
export NOSTRETCH=1
export NOBUSTER=1
export SONIC_BUILD_JOBS=24

######################################################################
#
# x. Local overrides
#
######################################################################

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
