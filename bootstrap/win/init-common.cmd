:: Install package installer
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

:: Install common tools
choco install 7zip /y
choco install wget /y

:: Although these tools are dev tools, but I use them on every kinds of machines, so they are put here.
choco install sysinternals /y
choco install fiddler4 /y