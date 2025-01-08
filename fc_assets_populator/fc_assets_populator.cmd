@echo off

taskkill /IM steamcmd.exe /F
taskkill /IM steam.exe /F
taskkill /IM "SteamCMD GUI.exe" /F
taskkill /IM OpenConsole.exe /F

cls

IF EXIST "C:\Program Files (x86)\Steam\steamapps\common\Source SDK Base 2013 Singleplayer" (
    ECHO Nice. Source SDK Base 2013 Singleplayer installed!
	pause
	goto go_first
) ELSE (
    echo At 1st we need to install Source SDK Base 2013 Singleplayer
	pause
	start steam://install/243730
	echo Wait until Source SDK Base 2013 Singleplayer fully installed and . . .
	pause
)

:go_first
REM Set this c:\Program Files (x86)\steam to your actual steam game directory
SET "l4d1ds=C:\Program Files (x86)\Steam\steamapps\common\Left 4 Dead"
SET "hlsds=C:\Program Files (x86)\Steam\steamapps\common\Half-Life 2"
SET "gmodds=C:\Program Files (x86)\Steam\steamapps\common\GarrysMod"

mkdir c:\temp\Updater
copy steamcmd.exe c:\temp\Updater\
cd c:\temp\Updater\
c:

cls
echo Let's start to install L4D1 assets!
steamcmd.exe +force_install_dir "%l4d1ds%" +login anonymous +app_update 222840 validate +quit

cls
echo Let's start to install HLS assets!
steamcmd.exe +force_install_dir "%hlsds%" +login anonymous +app_update 255470 validate +quit

cls
echo Let's start to install GMod assets!
steamcmd.exe +force_install_dir "%gmodds%" +login anonymous +app_update 4020 validate +quit

cls
echo Let's start to install HL2-EP1-EP2 assets!
xcopy "C:\Program Files (x86)\Steam\steamapps\common\Source SDK Base 2013 Singleplayer" "C:\Program Files (x86)\Steam\steamapps\common\half-life 2" /S /R /Y


cls
echo L4D1+HLS+HL2+Episodes+GMod assets are populated.
pause

taskkill /IM steamcmd.exe /F
taskkill /IM steam.exe /F
taskkill /IM "SteamCMD GUI.exe" /F
taskkill /IM OpenConsole.exe /F