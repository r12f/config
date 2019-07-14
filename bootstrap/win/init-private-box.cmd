call %~dp0.\init-primary-box.cmd

:: Install softwares for personal use only
choco install calibre /y

:: Install softwares which cannot be installed unattended.
choco install truecrypt /y