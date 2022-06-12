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
Set-Alias gpsh CallAlias-gps
function CallAlias-gpshf { & git push --force }
Set-Alias gpshf CallAlias-gpsf
function CallAlias-glg { & git log --stat }
Set-Alias glg CallAlias-glg
function CallAlias-glgp { & git log --stat -p }
Set-Alias glgp CallAlias-glgp
function CallAlias-glo { & git log --graph "--date=format:%y%m%d:%H%M" "--pretty=format:%C(auto)%h%d %C(bold blue)%an %Cgreen%ad - %Creset%s" $args }
Set-Alias glo CallAlias-glo
function CallAlias-gloga { & git log --oneline --decorate --graph --all }
Set-Alias gloga CallAlias-gloga
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
function CallAlias-gca { & git commit -v -a -m $args; & git push }
Set-Alias gca CallAlias-gca
function CallAlias-gca { & git commit -v -a --amend -m $args }
Set-Alias gca CallAlias-gca
function CallAlias-gco { & git checkout $args }
Set-Alias gco CallAlias-gco
function CallAlias-gcom { & git checkout master }
Set-Alias gcom CallAlias-gcom
function CallAlias-gcb { & git checkout user/%USERNAME%/$args }
Set-Alias gcb CallAlias-gcb
function CallAlias-gcnb { & git checkout -b user/%USERNAME%/$args }
Set-Alias gcnb CallAlias-gcnb
function CallAlias-gcp { & git cherry-pick $args }
Set-Alias gcp CallAlias-gcp
function CallAlias-gcpa { & git cherry-pick --abort $args }
Set-Alias gcpa CallAlias-gcpa
function CallAlias-gcpc { & git cherry-pick --continue $args }
Set-Alias gcpc CallAlias-gcpc

################################################################
#
# 3. Minikube
# 
# - n: nodes
# - d: deployment
# - ps: pods
# - p: pod
# - s: services
# - e: events
#
################################################################
function CallAlias-mk { & minikube kubectl -- $args }
Set-Alias mk CallAlias-mk

# Get
function CallAlias-mkg { & minikube kubectl -- get $args }
Set-Alias mkg CallAlias-mkg
function CallAlias-mkg-n { & minikube kubectl -- get nodes $args }
Set-Alias mkg-n CallAlias-mkg-n
function CallAlias-mkg-d { & minikube kubectl -- get deployment $args }
Set-Alias mkg-d CallAlias-mkg-d
function CallAlias-mkg-ps { & minikube kubectl -- get pods $args }
Set-Alias mkg-ps CallAlias-mkg-ps
function CallAlias-mkg-p { & minikube kubectl -- get pod $args }
Set-Alias mkg-p CallAlias-mkg-p
function CallAlias-mkg-s { & minikube kubectl -- get services $args }
Set-Alias mkg-s CallAlias-mkg-s
function CallAlias-mkg-e { & minikube kubectl -- get events $args }
Set-Alias mkg-e CallAlias-mkg-e

# Describe
function CallAlias-mkd { & minikube kubectl -- describe $args }
Set-Alias mkd CallAlias-mkd
function CallAlias-mkd-n { & minikube kubectl -- describe nodes $args }
Set-Alias mkd-n CallAlias-mkd-n
function CallAlias-mkd-p { & minikube kubectl -- describe pods $args }
Set-Alias mkd-p CallAlias-mkd-p

# Patch
function CallAlias-mkp-n { & minikube kubectl -- patch nodes $args }
Set-Alias mkp-n CallAlias-mkp-n
function CallAlias-mkp-d { & minikube kubectl -- patch deployment $args }
Set-Alias mkp-d CallAlias-mkp-d
function CallAlias-mkp-p { & minikube kubectl -- patch pod $args }
Set-Alias mkp-p CallAlias-mkp-p

# Top
function CallAlias-mktop { & minikube kubectl -- top $args }
Set-Alias mktop CallAlias-mktop
function CallAlias-mktop-n { & minikube kubectl -- top node $args }
Set-Alias mktop-n CallAlias-mktop-n
function CallAlias-mktop-p { & minikube kubectl -- top pod $args }
Set-Alias mktop-p CallAlias-mktop-p

# Expose
function CallAlias-mke { & minikube kubectl -- expose $args }
Set-Alias mke CallAlias-mke

# Log
function CallAlias-mkl { & minikube kubectl -- logs $args }
Set-Alias mkl CallAlias-mkl

# Copy
function CallAlias-mkcp { & minikube kubectl -- cp $args }
Set-Alias mkcp CallAlias-mkcp

################################################################
#
# 4. K8s
# 
# - n: nodes
# - d: deployment
# - ps: pods
# - p: pod
# - s: services
# - e: events
#
################################################################
function CallAlias-k { & kubectl -- $args }
Set-Alias k CallAlias-k

# Get
function CallAlias-kg { & kubectl -- get $args }
Set-Alias kg CallAlias-kg
function CallAlias-kg-n { & kubectl -- get nodes $args }
Set-Alias kg-n CallAlias-kg-n
function CallAlias-kg-d { & kubectl -- get deployment $args }
Set-Alias kg-d CallAlias-kg-d
function CallAlias-kg-ps { & kubectl -- get pods $args }
Set-Alias kg-ps CallAlias-kg-ps
function CallAlias-kg-p { & kubectl -- get pod $args }
Set-Alias kg-p CallAlias-kg-p
function CallAlias-kg-s { & kubectl -- get services $args }
Set-Alias kg-s CallAlias-kg-s
function CallAlias-kg-e { & kubectl -- get events $args }
Set-Alias kg-e CallAlias-kg-e

# Describe
function CallAlias-kd { & kubectl -- describe $args }
Set-Alias kd CallAlias-kd
function CallAlias-kd-n { & kubectl -- describe nodes $args }
Set-Alias kd-n CallAlias-kd-n
function CallAlias-kd-p { & kubectl -- describe pods $args }
Set-Alias kd-p CallAlias-kd-p

# Patch
function CallAlias-kp-n { & kubectl -- patch nodes $args }
Set-Alias kp-n CallAlias-kp-n
function CallAlias-kp-d { & kubectl -- patch deployment $args }
Set-Alias kp-d CallAlias-kp-d
function CallAlias-kp-p { & kubectl -- patch pod $args }
Set-Alias kp-p CallAlias-kp-p

# Top
function CallAlias-ktop { & kubectl -- top $args }
Set-Alias ktop CallAlias-ktop
function CallAlias-ktop-n { & kubectl -- top node $args }
Set-Alias ktop-n CallAlias-ktop-n
function CallAlias-ktop-p { & kubectl -- top pod $args }
Set-Alias ktop-p CallAlias-ktop-p

# Expose
function CallAlias-ke { & kubectl -- expose $args }
Set-Alias ke CallAlias-ke

# Log
function CallAlias-kl { & kubectl -- logs $args }
Set-Alias kl CallAlias-kl

# Copy
function CallAlias-kcp { & kubectl -- cp $args }
Set-Alias kcp CallAlias-kcp