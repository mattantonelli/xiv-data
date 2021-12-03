@echo off
SETLOCAL EnableDelayedExpansion

SET GAMEPATH="C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY XIV Online"
SET REPOPATH="C:\Users\Matt\Documents\Code\xiv-data"
SET FFMPEG="C:\Users\Matt\Documents\Code\xiv-data\ffmpeg.exe"
SET /p VERSION=<%GAMEPATH%\game\ffxivgame.ver

ECHO Setting SC definition to the latest game version...
COPY %GAMEPATH%\game\ffxivgame.ver Definitions\game.ver

ECHO [%TIME%] Extracting game data...
.\SaintCoinach.Cmd.exe %GAMEPATH% "allexd Achievement AchievementCategory AchievementKind Action ActionTransient Addon AozActionTransient BuddyEquip Companion CompanionMove CompanionTransient ContentFinderCondition Emote EmoteCategory Item MinionRace MinionSkillType Mount MountTransient MYCWarResultNotebook Orchestrion OrchestrionCategory Ornament Quest TextCommand Title"
.\SaintCoinach.Cmd.exe %GAMEPATH% "rawexd Achievement AozAction Cabinet CabinetCategory CharaMakeCustomize Emote GCScripShopItem GilShopItem ItemAction OrchestrionPath OrchestrionUiParam Recipe SpecialShop"

ECHO [%TIME%] Extracting images...
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 000000 069999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 072200 072652"
.\SaintCoinach.Cmd.exe %GAMEPATH% "uihd 131000 138999"
for /d %%i in (%CD%\%VERSION%\ui\icon\*) do (cd "%%i" & rmdir /S /Q hq 2>NUL)

ECHO [%TIME%] Compressing images...
"C:\Program Files\7-Zip\7z.exe" a %CD%\%VERSION%\ui.zip %CD%\%VERSION%\ui\* > NUL

ECHO Processing music...
.\SaintCoinach.Cmd.exe %GAMEPATH% "bgm bgm_ride bgm_orch"
for %%f in (%CD%\%VERSION%\music\ffxiv\*.ogg) do %FFMPEG% -y -i "%%f" -t 00:00:15.0 -b:a 32k -ar 22050 -loglevel quiet "%CD%\%VERSION%\music\%%~nf.ogg"
for %%f in (%CD%\%VERSION%\music\ffxiv\Orchestrion\*.ogg) do (
  set name=%%~nf
  set name=!name:~0,12!
  %FFMPEG% -y -i "%%f" -ss 00:00:10.0 -t 00:00:15.0 -b:a 32k -ar 22050 -loglevel quiet "%CD%\%VERSION%\music\!name!.ogg"
)
rmdir /S /Q %CD%\%VERSION%\music\ffxiv

ECHO [%TIME%] Compressing music...
"C:\Program Files\7-Zip\7z.exe" a %CD%\%VERSION%\music.zip %CD%\%VERSION%\music\* > NUL

ECHO [%TIME%] Copying game data to the local repository...
XCOPY /S /Y /Q %CD%\%VERSION%\exd-all %REPOPATH%\exd-all
XCOPY /S /Y /Q %CD%\%VERSION%\rawexd %REPOPATH%\rawexd
MOVE /Y %CD%\%VERSION%\ui.zip %REPOPATH%
MOVE /Y %CD%\%VERSION%\music.zip %REPOPATH%

ECHO [%TIME%] Extract complete.
pause
