@echo off

SET GAMEPATH="C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY XIV Online"
SET REPOPATH="C:\Users\Matt\Documents\Code\xiv-data"
SET /p VERSION=<%GAMEPATH%\game\ffxivgame.ver

ECHO Setting SC definition to the latest game version...
COPY %GAMEPATH%\game\ffxivgame.ver Definitions\game.ver

ECHO [%TIME%] Extracting game data...
.\SaintCoinach.Cmd.exe %GAMEPATH% "allexd Achievement ContentFinderCondition ENpcBase ENpcResident PlaceName Quest SpecialShop TripleTriad TripleTriadCard TripleTriadCardResident TripleTriadCardType TripleTriadRule"
.\SaintCoinach.Cmd.exe %GAMEPATH% "rawexd Level Map TripleTriad"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 082100 082999"

ECHO [%TIME%] Compressing images...
"C:\Program Files\7-Zip\7z.exe" a %CD%\%VERSION%\ui.zip %CD%\%VERSION%\ui\* > NUL

ECHO [%TIME%] Copying game data to the local repository...
XCOPY /S /Y /Q %CD%\%VERSION%\exd-all %REPOPATH%\exd-all
XCOPY /S /Y /Q %CD%\%VERSION%\rawexd %REPOPATH%\rawexd
MOVE /Y %CD%\%VERSION%\ui.zip %REPOPATH%

ECHO [%TIME%] Extract complete.
pause