call %~dp0.\init-primary-box.cmd

:: Install softwares for personal use only
choco install calibre /y
choco install steam /y

:: Install softwares which cannot be installed unattended.
choco install truecrypt /y
choco install battle.net /y