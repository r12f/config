::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: r12f's cmd init script (https://github.com/r12f/config)
:: email: r12f.code@gmail.com
::
:: This init script contains several sections:
:: 0. Environment settings
:: 1. Basic
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: 0. Environment settings
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Set config related environments
set CONFIG_ROOT=%~dp0.

:: Set editor
:: We cannot use "where" to find which editor we have, because we cannot use FOR to handle output of command now.
set EDITOR=gvim

:: Color prompt
if "%ConEmuANSI%" == "ON" (
    set PROMPT=$e[36m%USERNAME%$e[0m@$e[32m%COMPUTERNAME%:$e[33m$P$_$e[0m$G
) else (
    set PROMPT=%USERNAME%@%COMPUTERNAME%:$P$_$G
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: 1. Basic
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Create aliases
doskey /MACROFILE=%CONFIG_ROOT%\cmd-aliases.txt

