@echo off

:: Common tools
call :Install 7Zip.7Zip
call :Install Mobatek.MobaXterm
call :Install Microsoft.Powershell
call :Install WinDirStat.WinDirStat

:: Snipaste
call :Install 9P1WXPKB68KX

:: Windows terminal
call :Install 9N0DX20HK701

:: Sysinternals
call :Install 9P7KNL5RWT25

:: Adobe Reader
call :Install XPDP273C0XHQH2

:: Dev tools
call :Install Microsoft.VisualStudioCode
call :Install WiresharkFoundation.Wireshark

goto :eof

:Install
echo Installing %1 ...
winget install --accept-package-agreements --accept-source-agreements %1
echo.
exit /b