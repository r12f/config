######################################################################
#
# r12f's bash aliases (https://github.com/r12f/config)
# email: r12f.code@gmail.com
#
######################################################################

######################################################################
#
# 0. Environment settings
#
######################################################################
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
else
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
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

######################################################################
#
# 5. Git
#
######################################################################
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gcl='git clean -xfd'
alias gr='git reset'
alias grh='git reset --hard'
alias gr1='git reset HEAD~1'
alias gd='git diff'
alias gst='git status'
alias gpl='git pull'
alias gpsh='git push'
alias gpshf='git push --force'
alias glog='git log --graph "--date=format:%y%m%d:%H%M" "--pretty=format:%C(auto)%h%d %C(bold blue)%an %Cgreen%ad - %Creset%s"'
alias gloga='git log --oneline --decorate --graph --all'
alias glogv='git log --stat'
alias glogvv='git log --stat -p'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbm='git rebase origin/master'
alias grbmo='git rebase --onto origin/master'
alias gco='git checkout'
alias gcm='git checkout master'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

function gcf() {
    gf=`echo $@ | sed 's#github.com/[^/][^/]*/#github.com/r12f/#'`
    f=`basename $@ | sed 's/.git//'`

    echo "Cloning fork: $gf"
    git clone $gf --recurse-submodules

    echo ""
    echo "Setting up upstream to $@"
    cd $f && git remote add upstream $@ && git fetch upstream && cd -
}
function gcb() { git checkout user/${USER}/$@; }
function gcnb() { git checkout -b user/${USER}/$@; }
function gca() { git commit -v -a -m "$@" && git push; }

######################################################################
#
# 6. Docker
#
######################################################################

alias d='docker'

# Containers
alias d-ps='docker ps'
alias d-psa='docker ps -a'
alias d-rm='docker rm'
alias d-start='docker start'
alias d-stop='docker stop'
alias d-save='docker save'
alias d-load='docker load'
alias d-top='docker top'
alias d-ins='docker inspect'
function d-sh() { docker exec -it $1 bash; }
function d-shu() { docker exec -u ${USER} -it $1 bash; }
function d-shcu() { docker exec -u $2 -it $1 bash; }

# Images
alias d-i='docker images'
alias d-rmi='docker rmi'

######################################################################
#
# 7. K8s
#
# - n: nodes
# - d: deployment
# - ps: pods
# - p: pod
# - s: services
# - e: events
#
######################################################################

alias mk='minikube kubectl --'

# Start
alias mk-start='minikube start --cpus=4 --memory=6g --addons=ingress'

# Get
alias k-g='kubectl get'
alias k-gns='kubectl get nodes -o wide'
alias k-gd='kubectl get deployment'
alias k-gps='kubectl get pods -o wide -A'
alias k-gp='kubectl get pod -o wide'
alias k-gs='kubectl get services'
alias k-ge='kubectl get events'

# Describe
alias k-d='kubectl describe'
alias k-dn='kubectl describe nodes'
alias k-dp='kubectl describe pods'

# Apply
alias k-a='kubectl apply'

# Patch
alias k-pn='kubectl patch nodes'
alias k-pd='kubectl patch deployment'
alias k-pp='kubectl patch pod'

# Top
alias k-top='kubectl top'
alias k-topn='kubectl top node'
alias k-topp='kubectl top pod'

# Expose
alias k-e='kubectl expose'

# Log
alias k-l='kubectl logs'

# Copy
alias k-cp='kubectl cp'


######################################################################
#
# 8. Ansible
#
######################################################################

function asbl() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} "${@:2}"; }

# Ansible debug commands
function asbl-p() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m ping "${@:2}"; }
function asbl-dv() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m debug -a "var=$2" "${@:3}"; }

# Ansible frequently used commands
function asbl-sh() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m shell -a "${@:2}"; }
function asbl-upload() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m copy -a "src=$2 dest=$3" "${@:4}"; }
function asbl-cp() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m copy -a "remote_src=true src=$2 dest=$3" "${@:4}"; }

# Ansible package commands
function asbl-pi() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m package -b -a "state=present name=$2" "${@:3}"; }
function asbl-pu() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m package -b -a "state=absent name=$2" "${@:3}"; }
function asbl-snapi() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m snap -b -a "state=present name=$2" "${@:3}"; }
function asbl-snapic() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m snap -b -a "state=present classic=yes name=$2" "${@:3}"; }
function asbl-snapiec() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m snap -b -a "state=present channel=latest/edge classic=yes name=$2" "${@:3}"; }
function asbl-snapu() { ansible $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} -m snap -b -a "state=absent name=$2" "${@:3}"; }

# Ansible playbook command
function asblp() { ansible-playbook $1 ${ANSIBLE_INVENTORY} -e @${ANSIBLE_VAULT_FILE} "${@:2}"; }

# Ansible vault commands
function asblv-e() { ansible-vault encrypt "$@"; }
function asblv-ec() { ANSIBLE_VAULT_PASSWORD_FILE= ansible-vault encrypt --ask-vault-pass "$@"; }
function asblv-d() { ansible-vault decrypt "$@"; }
function asblv-dc() { ANSIBLE_VAULT_PASSWORD_FILE= ansible-vault decrypt --ask-vault-pass "$@"; }
function asblv-r() { ansible-vault rekey "$@"; }
function asblv-rc() { ANSIBLE_VAULT_PASSWORD_FILE= ansible-vault rekey --ask-vault-pass "$@"; }

######################################################################
#
# 9. Dev aliases
#
######################################################################

function j() { just "$@"; }
function j-b() { just build "$@"; }
function j-t() { just test "$@"; }
function j-f() { just format "$@"; }
function j-l() { just lint "$@"; }
function j-lf() { just lint-fix "$@"; }
function j-doc() { just doc "$@"; }