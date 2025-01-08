@echo off

setlocal
call :setESC
cls

taskkill /IM OpenConsole.exe /F
cls

echo %ESC%[31;1mIf you are getting errors from Github - check speed at speedtest.net%ESC%[0m
echo %ESC%[31;1mCheck your cable/router/wifi/storage/ram - fix it and try again%ESC%[0m
echo.

 
IF EXIST "c:\Program Files (x86)\steam\steamapps\sourcemods\fc\.git" (
    echo %ESC%[93mFC folder was automatically found at: "c:\Program Files (x86)\steam\steamapps\sourcemods\fc"%ESC%[0m
	call :setUpdate
	pause
	taskkill /IM conhost.exe /F
	exit
) ELSE IF EXIST "c:\Program Files (x86)\steam\steamapps\sourcemods\" (
    echo %ESC%[93mSourcemods folder was automatically found at: "c:\Program Files (x86)\steam\steamapps\sourcemods"%ESC%[0m
	call :setInstall
	pause
	taskkill /IM conhost.exe /F
	exit
) ELSE (
    echo %ESC%[93mWARNING: Steam's Sourcemods folder has not been found, or you chose not to use it. Make sure Steam is fully installed or its registry paths fixed.%ESC%[0m
	call :setManual
	pause
	taskkill /IM conhost.exe /F
	exit
)

pause
taskkill /IM cmd.exe /F
taskkill /IM conhost.exe /F
taskkill /IM OpenConsole.exe /F
exit

:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)

:setUpdate
set /p choice=Do you want to update it? (Y/N):
	if /i "%choice%"=="Y" (
		cls
		echo %ESC%[31;1mBackup your FC config files and press SPACE%ESC%[0m
		pause
		cls
		echo Updating %ESC%[38;5;141mFortress Connected%ESC%[0m...
		.\Misc\PortableGit\bin\git --work-tree="c:\Program Files (x86)\steam\steamapps\sourcemods\fc" --git-dir="c:\Program Files (x86)\steam\steamapps\sourcemods\fc\.git" gc --auto
		.\Misc\PortableGit\bin\git --work-tree="c:\Program Files (x86)\steam\steamapps\sourcemods\fc" --git-dir="c:\Program Files (x86)\steam\steamapps\sourcemods\fc\.git" checkout .
		.\Misc\PortableGit\bin\git --work-tree="c:\Program Files (x86)\steam\steamapps\sourcemods\fc" --git-dir="c:\Program Files (x86)\steam\steamapps\sourcemods\fc\.git" pull
		echo %ESC%[92mWell done. Restart Steam and play FC%ESC%[0m
		echo %ESC%[31;1mFatal. Not a git repository - restart downloader and choose N%ESC%[0m
		pause
		taskkill /IM conhost.exe /F
		exit
	) else (
		cls
		echo %ESC%[31;1mThis will fix installation folder%ESC%[0m
		pause
		rd /s /q "c:\Program Files (x86)\steam\steamapps\sourcemods\fc\.git"
		echo %ESC%[92mDone. Press SPACE%ESC%[0m
		pause 
		taskkill /IM conhost.exe /F
		exit
	)

:setInstall
set /p choice=It's the recommended installation location. Would you like to install %ESC%[38;5;141mFortress Connected%ESC%[0m there? (Y/N):
	if /i "%choice%"=="Y" (
		cls
		echo Installing %ESC%[38;5;141mFortress Connected%ESC%[0m to the %ESC%[96mSourcemods%ESC%[0m folder...
		.\Misc\PortableGit\bin\git clone -b dev https://github.com/Lambdagon/fc.git "c:\Program Files (x86)\steam\steamapps\sourcemods\fc"
	) else (
		cls
		call :setManual
		rem Perform actions for No
		pause
		taskkill /IM conhost.exe /F
		exit
	)

:setManual
set /p choice=Would you like to extract in %ESC%[96mcurrent%ESC%[0m folder? You must move it to your %ESC%[96mSourcemods%ESC%[0m manually. (Y/N)
	if /i "%choice%"=="Y" (
		rem Perform actions for Yes
		.\Misc\PortableGit\bin\git clone -b dev https://github.com/Lambdagon/fc.git
		echo %ESC%[38;5;141mFortress Connected%ESC%[0m installed. Move it to your %ESC%[96mSourcemods%ESC%[0m folder manually, restart Steam and run %ESC%[38;5;141mFortress Connected%ESC%[0m
	) else (
		cls
		echo %ESC%[38;5;141mFortress Connected%ESC%[0m will be installed to the %ESC%[96mDesktop%ESC%[0m folder
		pause
		cls
		echo Installing %ESC%[38;5;141mFortress Connected%ESC%[0m to the %ESC%[96mDesktop%ESC%[0m folder...
		.\Misc\PortableGit\bin\git clone -b dev https://github.com/Lambdagon/fc.git "%USERPROFILE%\Desktop\fc"
		cls
		echo %ESC%[38;5;141mFortress Connected%ESC%[0m installed. Move it to your %ESC%[96mSourcemods%ESC%[0m folder manually, restart Steam and run %ESC%[38;5;141mFortress Connected%ESC%[0m
		pause
		taskkill /IM conhost.exe /F
		exit
	)	