@echo off

set CONFIG_ROOT=%~dp0.
set CMD_CONFIG_ROOT=%CONFIG_ROOT%\cmd
set VIM_CONFIG_ROOT=%CONFIG_ROOT%\vimrc

echo Install configuration ...

:: Install command prompt configuration
echo Install command prompt configuration ...
reg add "HKLM\Software\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "%CMD_CONFIG_ROOT%\cmd-init.cmd" /f > nul
echo.

:: Install VIM configuration
call %VIM_CONFIG_ROOT%\install.cmd
echo.

echo Configuration installation complete!
