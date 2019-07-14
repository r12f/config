call %~dp0.\init-common.cmd

:: Install frequently used softwares
choco install adobereader /y
choco install windirstat /y
choco install defraggler /y
choco install filezilla /y
choco install vim /y

:: Install dev tools
choco install git /y
choco install golang /y
choco install python /y
choco install dotpeek /y
choco install putty /y

:: Install media players
choco install smplayer /y