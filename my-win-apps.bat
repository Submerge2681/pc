@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Ensure script is run as Administrator
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Please run this script as Administrator.
    pause
    exit /b
)

:: Install Chocolatey if not installed
where choco >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
     "Set-ExecutionPolicy Bypass -Scope Process -Force; ^
      [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ^
      iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
) ELSE (
    echo Chocolatey is already installed.
)

:: Refresh environment variables
refreshenv

:: List of applications to install
SET APPS=^
bat ^
calibre ^
cmake ^
ffmpeg-full ^
git ^
golang ^
notepadplusplus ^
nvm ^
peazip ^
postman ^
pyenv-win ^
rufus ^
rust ^
syncthing ^
yt-dlp ^
kdeconnect-kde ^
librewolf ^
libreoffice ^
exiftool ^
steghide ^
tldr ^
navi ^
protonvpn

:: Install applications
FOR %%A IN (%APPS%) DO (
    echo Installing %%A...
    choco install %%A -y --ignore-checksums
)

echo.
echo All applications have been installed.
pause
