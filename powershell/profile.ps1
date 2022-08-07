################################################################
#
# r12f's powershell init script (https#//github.com/r12f/config)
# email# r12f.code@gmail.com
#
# This init script contains several sections:
# 0. Environment settings
# 1. Aliases
#
################################################################

################################################################
#
# 0. Environment settings
#
################################################################
$env:CONFIG_ROOT = Split-Path -Parent $MyInvocation.MyCommand.Definition
$env:MY_EDITOR = "gvim"

function Prompt
{
    $origLastExitCode = $LASTEXITCODE

    # Print the current time:
    Write-Host ("[") -nonewline -foregroundcolor DarkGray
    Write-Host (Get-Date -format HH:mm:ss) -nonewline -foregroundcolor Gray
    Write-Host ("] ") -nonewline -foregroundcolor DarkGray

    # Username
    Write-Host "$env:USERNAME" -ForegroundColor DarkCyan -NoNewline
    Write-Host "@" -NoNewLine

    # Machine
    Write-Host "$env:COMPUTERNAME" -ForegroundColor DarkGreen -NoNewLine
    Write-Host ":" -ForegroundColor DarkGreen -NoNewLine

    # Directory
    Write-Host "$(Get-Location)" -ForegroundColor DarkYellow -NoNewLine

    if (Get-Command "Write-VcsStatus" -errorAction SilentlyContinue)
    {
        Write-VcsStatus
    }

    Write-Host ''
    Write-Host ">" -NoNewLine

    $LASTEXITCODE = $origLastExitCode
    return " ";
}

################################################################
#
# 1. Aliases
#
################################################################
function CallAlias-e { if ($args -ne 0) { start $env:MY_EDITOR $args } else { start $env:MY_EDITOR } }
Set-Alias e CallAlias-e
function CallAlias-f { if ($args -ne 0) { start start $args } else { start . } }
Set-Alias f CallAlias-f
function CallAlias-.. { cd .. }
Set-Alias .. CallAlias-..
function CallAlias-... { cd ..\.. }
Set-Alias ... CallAlias-...
function CallAlias-.2 { cd ..\.. }
Set-Alias .2 CallAlias-.2
function CallAlias-.3 { cd ..\..\.. }
Set-Alias .3 CallAlias-.3
function CallAlias-.4 { cd ..\..\..\.. }
Set-Alias .4 CallAlias-.4
function CallAlias-.5 { cd ..\..\..\..\.. }
Set-Alias .5 CallAlias-.5
function CallAlias-.6 { cd ..\..\..\..\..\.. }
Set-Alias .6 CallAlias-.6
function CallAlias-~ { cd /d $env:USERPROFILE }
Set-Alias ~ CallAlias-~
function CallAlias-l { dir -Force $args }
Set-Alias l CallAlias-l
function CallAlias-la { dir -Force  $args }
Set-Alias la CallAlias-la

################################################################
#
# 2. Git
#
################################################################
function CallAlias-ga { & git add $args }
Set-Alias ga CallAlias-ga
function CallAlias-gaa { & git add --all $args }
Set-Alias gaa CallAlias-gaa
function CallAlias-gb { & git branch $args }
Set-Alias gb CallAlias-gb
function CallAlias-gcl { & git clean -xfd $args }
Set-Alias gcl CallAlias-gcl
function CallAlias-gr { & git reset $args }
Set-Alias gr CallAlias-gr
function CallAlias-grh { & git reset --hard $args }
Set-Alias grh CallAlias-grh
function CallAlias-gr1 { & git reset HEAD~1 $args }
Set-Alias gr1 CallAlias-gr1
function CallAlias-gd { & git diff }
Set-Alias gd CallAlias-gd
function CallAlias-gst { & git status }
Set-Alias gst CallAlias-gst
function CallAlias-gpl { & git pull $args }
Set-Alias gpl CallAlias-gpl
function CallAlias-gpsh { & git push $args }
Set-Alias gpsh CallAlias-gpsh
function CallAlias-gpshf { & git push --force }
Set-Alias gpshf CallAlias-gpshf
function CallAlias-glog { & git log --graph "--date=format:%y%m%d:%H%M" "--pretty=format:%C(auto)%h%d %C(bold blue)%an %Cgreen%ad - %Creset%s" $args }
Set-Alias glog CallAlias-glog
function CallAlias-gloga { & git log --oneline --decorate --graph --all }
Set-Alias gloga CallAlias-gloga
function CallAlias-glogv { & git log --stat }
Set-Alias glogv CallAlias-glogv
function CallAlias-glogvv { & git log --stat -p }
Set-Alias glogvv CallAlias-glogvv
function CallAlias-grb { & git rebase $args }
Set-Alias grb CallAlias-grb
function CallAlias-grba { & git rebase --abort }
Set-Alias grba CallAlias-grba
function CallAlias-grbc { & git rebase --continue }
Set-Alias grbc CallAlias-grbc
function CallAlias-grbm { & git rebase origin/master $args }
Set-Alias grbm CallAlias-grbm
function CallAlias-grbmo { & git rebase --onto origin/master $args }
Set-Alias grbmo CallAlias-grbmo
function CallAlias-gca { & git add .; & git commit -m $args; & git push }
Set-Alias gca CallAlias-gca
function CallAlias-gco { & git checkout $args }
Set-Alias gco CallAlias-gco
function CallAlias-gcom { & git checkout master }
Set-Alias gcom CallAlias-gcom
function CallAlias-gcb { & git checkout user/${env:USERNAME}/$args }
Set-Alias gcb CallAlias-gcb
function CallAlias-gcnb { & git checkout -b user/${env:USERNAME}/$args }
Set-Alias gcnb CallAlias-gcnb
function CallAlias-gcp { & git cherry-pick $args }
Set-Alias gcp CallAlias-gcp
function CallAlias-gcpa { & git cherry-pick --abort $args }
Set-Alias gcpa CallAlias-gcpa
function CallAlias-gcpc { & git cherry-pick --continue $args }
Set-Alias gcpc CallAlias-gcpc

################################################################
#
# 3. K8s
# 
# - n: nodes
# - d: deployment
# - ps: pods
# - p: pod
# - s: services
# - e: events
#
################################################################
# Minikube
function CallAlias-mk { & minikube kubectl -- $args }
Set-Alias mk CallAlias-mk

function CallAlias-mk-start { & minikube start --cpus=4 --memory=6g --addons=ingress }
Set-Alias mk-start CallAlias-mk-start

# Kubectl
function CallAlias-k { & kubectl $args }
Set-Alias k CallAlias-k

# Config - Use Context
function CallAlias-k-use-mk { & kubectl config use-context minikube $args }
Set-Alias k-use-mk CallAlias-k-use-mk

# Get
function CallAlias-k-g { & kubectl get $args }
Set-Alias k-g CallAlias-k-g
function CallAlias-k-gns { & kubectl get nodes -o wide -A $args }
Set-Alias k-gns CallAlias-k-gns
function CallAlias-k-gd { & kubectl get deployment $args }
Set-Alias k-gd CallAlias-k-gd
function CallAlias-k-gps { & kubectl get pods -o wide -A $args }
Set-Alias k-gps CallAlias-k-gps
function CallAlias-k-gp { & kubectl get pod -o wide $args }
Set-Alias k-gp CallAlias-k-gp
function CallAlias-k-gs { & kubectl get services $args }
Set-Alias k-gs CallAlias-k-gs
function CallAlias-k-ge { & kubectl get events $args }
Set-Alias k-ge CallAlias-k-ge
function CallAlias-k-gpw { & kubectl get secret $args -o jsonpath="{.data.password}" }
Set-Alias k-gpw CallAlias-k-gpw

# Describe
function CallAlias-k-d { & kubectl describe $args }
Set-Alias k-d CallAlias-k-d
function CallAlias-k-dn { & kubectl describe nodes $args }
Set-Alias k-dn CallAlias-k-dn
function CallAlias-k-dp { & kubectl describe pods $args }
Set-Alias k-dp CallAlias-k-dp

# Apply
function CallAlias-k-a { & kubectl apply $args }
Set-Alias k-a CallAlias-k-a
function CallAlias-k-af { & kubectl apply -f $args }
Set-Alias k-af CallAlias-k-af

# Patch
function CallAlias-k-pn { & kubectl patch nodes $args }
Set-Alias k-pn CallAlias-k-pn
function CallAlias-k-pd { & kubectl patch deployment $args }
Set-Alias k-pd CallAlias-k-pd
function CallAlias-k-pp { & kubectl patch pod $args }
Set-Alias k-pp CallAlias-k-pp

# Top
function CallAlias-k-top { & kubectl top $args }
Set-Alias k-top CallAlias-k-top
function CallAlias-k-topn { & kubectl top node $args }
Set-Alias k-topn CallAlias-k-topn
function CallAlias-k-topp { & kubectl top pod $args }
Set-Alias k-topp CallAlias-k-topp

# Expose
function CallAlias-k-e { & kubectl expose $args }
Set-Alias k-e CallAlias-k-e

# Log
function CallAlias-k-l { & kubectl logs $args }
Set-Alias k-l CallAlias-k-l

# Copy
function CallAlias-k-cp { & kubectl cp $args }
Set-Alias k-cp CallAlias-k-cp

# Debug
function CallAlias-k-dbgpc { & kubectl debug -it --image=ubuntu --share-processes --copy-to=debug-pod-${env:USERNAME} $args }
Set-Alias k-dbgpc CallAlias-k-dbgpc

function CallAlias-k-dbgc { & kubectl delete pod debug-pod-${env:USERNAME} $args }
Set-Alias k-dbgc CallAlias-k-dbgc

################################################################
#
# Other stuffs
# 
################################################################

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
