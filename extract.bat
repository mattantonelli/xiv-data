@echo off

SET GAMEPATH="C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY XIV Online"
SET REPOPATH="C:\Users\Matt\Documents\Code\xiv-data"
SET FFMPEG="C:\Users\Matt\Documents\Code\xiv-data\ffmpeg.exe"
SET /p VERSION=<%GAMEPATH%\game\ffxivgame.ver
SET DATAPATH="%CD%\%VERSION%"

ECHO Setting SC definition to the latest game version...
COPY %GAMEPATH%\game\ffxivgame.ver Definitions\game.ver

ECHO [%TIME%] Extracting game data...
.\SaintCoinach.Cmd.exe %GAMEPATH% "allexd Achievement AchievementCategory AchievementKind Action ActionTransient Addon AozActionTransient BannerBg BannerDecoration BannerFrame BuddyEquip CharaCardBase CharaCardDecoration CharaCardHeader Companion CompanionMove CompanionTransient ContentFinderCondition Emote EmoteCategory ENpcBase ENpcResident Item MinionRace MinionSkillType Mount MountTransient MYCWarResultNotebook Orchestrion OrchestrionCategory Ornament PlaceName Quest SpecialShop TextCommand Title TripleTriad TripleTriadCard TripleTriadCardResident TripleTriadCardType TripleTriadRule VVDNotebookContents VVDNotebookSeries"
.\SaintCoinach.Cmd.exe %GAMEPATH% "rawexd Achievement AozAction BannerCondition Cabinet CabinetCategory CharaMakeCustomize Emote GCScripShopItem GilShopItem InstanceContent Item ItemAction Level Map OrchestrionPath OrchestrionUiParam PvPSeries Recipe SpecialShop TripleTriad VVDNotebookSeries"

ECHO [%TIME%] Extracting images...
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 000000 070999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 072200 072652"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 076000 076999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 087000 088999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 190000 199999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "uihd 130000 139999"
for /d %%i in (%DATAPATH%\ui\icon\*) do (cd "%%i" & rmdir /S /Q hq 2>NUL)
CD "%DATAPATH%\.."

ECHO [%TIME%] Compressing images...
"C:\Program Files\7-Zip\7z.exe" a %DATAPATH%\ui.zip %DATAPATH%\ui\* > NUL

ECHO Processing music...
.\SaintCoinach.Cmd.exe %GAMEPATH% "bgm bgm_ride bgm_orch"
for %%f in (%DATAPATH%\music\ffxiv\*.ogg) do %FFMPEG% -y -i "%%f" -t 00:00:15.0 -b:a 32k -ar 22050 -loglevel quiet "%DATAPATH%\music\%%~nf.ogg"

for %%f in (%DATAPATH%\music\ffxiv\Orchestrion\*.ogg) do (
  set input="%%f"

  rem We need to enable delayed expansion AFTER setting the input variable or it will eat the !'s
  SETLOCAL EnableDelayedExpansion
  set name=%%~nf
  set name=!name:~0,12!
  set output="%DATAPATH%\music\!name!.ogg"
  %FFMPEG% -y -i !input! -ss 00:00:10.0 -t 00:00:15.0 -b:a 32k -ar 22050 -loglevel quiet !output!
  ENDLOCAL
)

rmdir /S /Q %DATAPATH%\music\ffxiv

ECHO [%TIME%] Compressing music...
"C:\Program Files\7-Zip\7z.exe" a %DATAPATH%\music.zip %DATAPATH%\music\* > NUL

ECHO [%TIME%] Copying game data to the local repository...
XCOPY /S /Y /Q %DATAPATH%\exd-all %REPOPATH%\exd-all
XCOPY /S /Y /Q %DATAPATH%\rawexd %REPOPATH%\rawexd
MOVE /Y %DATAPATH%\ui.zip %REPOPATH%
MOVE /Y %DATAPATH%\music.zip %REPOPATH%

ECHO [%TIME%] Extract complete.
pause
