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
function CallAlias-e { if ($args -NE 0) { start $env:MY_EDITOR $args } else { start $env:MY_EDITOR } }
Set-Alias e CallAlias-e
function CallAlias-f { if ($args -NE 0) { start start $args } else { start . } }
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
