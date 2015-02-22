@echo off

reg add "HKLM\Software\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "C:\Users\Riff\config\cmd\cmd-init.cmd" /f > nul
