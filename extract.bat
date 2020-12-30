@echo off
SET GAMEPATH="C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY XIV Online"
SET REPOPATH="C:\Users\Matt\Documents\Code\xiv-data"
SET /p VERSION=<%GAMEPATH%\game\ffxivgame.ver

ECHO Setting SC definition to the latest game version...
COPY %GAMEPATH%\game\ffxivgame.ver Definitions\game.ver

ECHO Extracting game data...
.\SaintCoinach.Cmd.exe %GAMEPATH% "allexd ENpcBase ENpcResident TripleTriad TripleTriadCard TripleTriadCardResident TripleTriadCardType TripleTriadRule PlaceName Quest ContentFinderCondition Achievement"
.\SaintCoinach.Cmd.exe %GAMEPATH% "rawexd Level TripleTriad Map"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 082101 082999"

ECHO Copying game data to the local repository...
XCOPY /S /Y /Q %CD%\%VERSION% %REPOPATH%
pause