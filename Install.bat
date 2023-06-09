@ECHO OFF
:BEGIN
color 2
CLS

CHOICE /C:YN /M "Install Google Earth Pro?"
IF %ERRORLEVEL% EQU 1 winget install --id=Google.EarthPro -e
echo.
color 2

CHOICE /C:YN /M "Install Foxit Reader?"
IF %ERRORLEVEL% EQU 1 winget install --id=Foxit.FoxitReader -e -i
echo.
color 2

CHOICE /C:YN /M "Install 7-Zip?"
IF %ERRORLEVEL% EQU 1 winget install --id=7zip.7zip -e
echo.
color 2

CHOICE /C:YN /M "Install Teams?"
IF %ERRORLEVEL% EQU 1 winget install --id=Microsoft.Teams -e --scope=Machine
echo.
color 2

CHOICE /C:YN /M "Install Global Mapper?"
IF %ERRORLEVEL% EQU 1 winget install --id=BlueMarbleGeographics.GlobalMapper -e -i
echo.
color 2

CHOICE /C:YN /M "Install Open Office?"
IF %ERRORLEVEL% EQU 1 winget install --id=Apache.OpenOffice -e --locale en-us
echo.
color 2

CHOICE /C:YN /M "Install Global VPN Client?"
IF %ERRORLEVEL% EQU 1 winget winget install --id=SonicWALL.GlobalVPN -e
echo.
color 2

echo.
echo.
echo.
echo.
echo.
echo        .o.       oooo  oooo      oooooooooo.                                   
echo       .888.      `888  `888      `888'   `Y8b                                  
echo      .8"888.      888   888       888      888  .ooooo.  ooo. .oo.    .ooooo.  
echo     .8' `888.     888   888       888      888 d88' `88b `888P"Y88b  d88' `88b 
echo    .88ooo8888.    888   888       888      888 888   888  888   888  888ooo888 
echo   .8'     `888.   888   888       888     d88' 888   888  888   888  888    .o 
echo  o88o     o8888o o888o o888o     o888bood8P'   `Y8bod8P' o888o o888o `Y8bod8P' 
echo.
echo.
echo.
echo.
echo.
