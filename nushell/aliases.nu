######################################################################
#
# 1. Basic terminal commands
#
######################################################################
alias c = clear

######################################################################
#
# 2. File and directory control
#
######################################################################
alias e = $env.MY_EDITOR                    # Open in default editor

alias ll = ls -l                            # List files in list
alias la = ls -a                            # List all files in list style
alias lla = ls -la                          # List all files in list style
alias l = lla                               # Preferred ls format
alias dir = lla                             # For DOS style

alias cd.. = cd ../                         # Go to parent directory for DOS style
alias .. = cd ../                           # Go up to parent directory
alias ... = cd ../../                       # Go up 2 times
alias cd.3 = cd ../../../                   # Go up 3 times
alias cd.4 = cd ../../../../                # Go up 4 times
alias cd.5 = cd ../../../../../             # Go up 5 times
alias cd.6 = cd ../../../../../../          # Go up 6 times
alias ~ = cd ~                              # Go to home directory

alias mv = mv -iv                           # Move files with confirming and verbose
alias cp = cp -iv                           # Copy files with confirming and verbose

alias fd = find ./ -name                    # Search files in current folder

# Extract files
def extract [$name] {
    if $name ends-with ".zip" { unzip $name; }
    else if $name ends-with ".rar" { unrar e $name; }
    else if $name ends-with ".7z" { 7z x $name; }
    else if $name ends-with ".tar" { tar xvf $name; }
    else if $name ends-with ".gz" { gunzip $name; }
    else if $name ends-with ".tgz" { tar xvf $name; }
    else if $name ends-with ".tar.gz" { tar xvf $name; }
    else if $name ends-with ".tar.bz2" { tar xjvf $name; }
    else if $name ends-with ".tbz2" { tar xjvf $name; }
    else { echo "Error: Unknown file type: $name" }
}

######################################################################
#
# 3. Process control
#
######################################################################
alias p = ps -o user,pid,%cpu,%mem,start,time,command           # Default process output format
alias pa = p ax                                                 # List all processes
alias pu = p -U                                                 # List processes of certain user
alias pme = pu $env.USER                                        # List my processes

######################################################################
#
# 4. Text manipulation
#
######################################################################
alias grep = grep --color=auto
alias fgrep = fgrep --color=auto
alias egrep = egrep --color=auto

######################################################################
#
# 5. Git
#
######################################################################
alias ga = git add
alias gaa = git add --all
alias gb = git branch
alias gcl = git clean -xfd
alias gr = git reset
alias grh = git reset --hard
alias gr1 = git reset HEAD~1
alias gd = git diff
alias gst = git status
alias gpl = git pull
alias gpsh = git push
alias gpshf = git push --force
alias glog = git log --graph "--date=format:%y%m%d:%H%M" "--pretty=format:%Cauto%h%d %Cbold blue%an %Cgreen%ad - %Creset%s"
alias gloga = git log --oneline --decorate --graph --all
alias glogv = git log --stat
alias glogvv = git log --stat -p
alias grb = git rebase
alias grba = git rebase --abort
alias grbc = git rebase --continue
alias grbm = git rebase origin/master
alias grbmo = git rebase --onto origin/master
alias gco = git checkout
alias gcm = git checkout master
alias gcp = git cherry-pick
alias gcpa = git cherry-pick --abort
alias gcpc = git cherry-pick --continue

def gcb [name: string] { git checkout user/($env.USER)/$name; }
def gcnb [name: string] { git checkout -b user/($env.USER)/$name; }
def gca [message: string] { git commit -v -a -m "$message" && git push; }

######################################################################
#
# 6. Minikube
#
# - n: nodes
# - d: deployment
# - ps: pods
# - p: pod
# - s: services
# - e: events
#
######################################################################
alias mk = minikube kubectl --

# Start
alias mk-start = minikube start --cpus=4 --memory=6g --addons=ingress

# Get
alias k-g = kubectl get
alias k-gns = kubectl get nodes -o wide
alias k-gd = kubectl get deployment
alias k-gps = kubectl get pods -o wide -A
alias k-gp = kubectl get pod -o wide
alias k-gs = kubectl get services
alias k-ge = kubectl get events

# Describe
alias k-d = kubectl describe
alias k-dn = kubectl describe nodes
alias k-dp = kubectl describe pods

# Apply
alias k-a = kubectl apply

# Patch
alias k-pn = kubectl patch nodes
alias k-pd = kubectl patch deployment
alias k-pp = kubectl patch pod

# Top
alias k-top = kubectl top
alias k-topn = kubectl top node
alias k-topp = kubectl top pod

# Expose
alias k-e = kubectl expose

# Log
alias k-l = kubectl logs

# Copy
alias k-cp = kubectl cp


######################################################################
#
# 7. Ansible
#
######################################################################

# Ansible debug commands
def asbl-p [name: string, ...args: string] { ansible $name -e @$env.ANSIBLE_VAULT_FILE -m ping ($args | str join); }
def asbl-dv [name: string, var_name: string, ...args: string] { ansible $name -e @$env.ANSIBLE_VAULT_FILE -m debug -a "var=($var_name)" ($args | str join); }

# Ansible playbook command
alias asblp = ansible-playbook -e @$env.ANSIBLE_VAULT_FILE

# Ansible vault commands
alias asblv-e = ansible-vault encrypt
alias asblv-ec = ansible-vault encrypt --ask-vault-pass
alias asblv-d = ansible-vault decrypt
alias asblv-dc = ansible-vault decrypt --ask-vault-pass
alias asblv-r = ansible-vault rekey
alias asblv-rc = ansible-vault rekey --ask-vault-pass

######################################################################
#
# 8. Dev aliases
#
######################################################################

alias j = just
alias j-b = just build
alias j-t = just test
alias j-f = just format
alias j-l = just lint
alias j-lf = just lint-fix
alias j-doc = just doc