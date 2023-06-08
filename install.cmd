@echo off

set CONFIG_ROOT=%~dp0.
set CMD_CONFIG_ROOT=%CONFIG_ROOT%\cmd
set POWERSHELL_CONFIG_ROOT=%CONFIG_ROOT%\powershell
set VIM_CONFIG_ROOT=%CONFIG_ROOT%\vimrc

echo Install configuration ...

:: Install command prompt configuration
echo Install command prompt configuration ...
reg add "HKLM\Software\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "%CMD_CONFIG_ROOT%\cmd-init.cmd" /f > nul

:: Install powershell configuration
echo Install powershell prompt configuration ...
if not exist "%USERPROFILE%\Documents\WindowsPowerShell" (
    mkdir "%USERPROFILE%\Documents\WindowsPowerShell"
)
call :CreateSymbolLinkWithBackup %POWERSHELL_CONFIG_ROOT%\profile.ps1 %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

if not exist "%USERPROFILE%\Documents\PowerShell" (
    mkdir "%USERPROFILE%\Documents\PowerShell"
)
call :CreateSymbolLinkWithBackup %POWERSHELL_CONFIG_ROOT%\profile.ps1 %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
call :CreateSymbolLinkWithBackup %POWERSHELL_CONFIG_ROOT%\profile.ps1 %USERPROFILE%\Documents\PowerShell\Profile.ps1

:: Install VIM configuration
echo.
call %VIM_CONFIG_ROOT%\install.cmd

:: Complete
echo.
echo Configuration installation complete!
exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Function: CreateSymbolLinkWithBackup
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:CreateSymbolLinkWithBackup
set source_file=%1
set dest_file=%2

call :CreateBackupFileIfNeeded
if not errorlevel 0 (
    exit /b 1
)

echo Creating symbol link: "%dest_file%" -^> "%source_file%"
if exist %source_file%\ (
    mklink /D "%dest_file%" "%source_file%"
) else (
    mklink "%dest_file%" "%source_file%"
)
if not errorlevel 0 (
    echo Create backup failed.
    exit /b 1
)

exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Function: CreateBackupFileIfNeeded
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:CreateBackupFileIfNeeded
if not exist "%dest_file%" (
    exit /b 0
)

set backup_id=0
set backup_file=%dest_file%.bak

:CheckBackupFileExist
if exist "%backup_file%" (
    set /a backup_id+=1
    set backup_file=%dest_file%.%backup_id%.bak
    goto :CheckBackupFileExist
)

echo Backing up "%dest_file%" to "%backup_file%" ...
move %dest_file% %backup_file% >nul 2>&1
if not errorlevel 0 (
    echo Create backup failed.
    exit /b 1
)

exit /b 0
