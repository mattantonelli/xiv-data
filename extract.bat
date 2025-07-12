@echo off

SET GAMEPATH="D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn"
SET REPOPATH="C:\Users\Matt\Documents\Code\xiv-data"
SET FFMPEG="C:\Users\Matt\Documents\Code\xiv-data\ffmpeg.exe"
SET /p VERSION=<%GAMEPATH%\game\ffxivgame.ver
SET DATAPATH="%CD%\%VERSION%"

ECHO Setting SC definition to the latest game version...
COPY %GAMEPATH%\game\ffxivgame.ver Definitions\game.ver

ECHO [%TIME%] Extracting images...
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 000000 070999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 072200 072652"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 076000 076999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 087000 088999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 190000 199999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "uihd 130000 139999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "uihd 200001 200999"
for /d %%i in (%DATAPATH%\ui\icon\*) do (cd "%%i" & rmdir /S /Q hq 2>NUL)
CD "%DATAPATH%\.."

ECHO [%TIME%] Compressing images...
"C:\Program Files\7-Zip\7z.exe" a %DATAPATH%\ui.zip %DATAPATH%\ui\* > NUL

ECHO [%TIME%] Copying game data to the local repository...
MOVE /Y %DATAPATH%\ui.zip %REPOPATH%

ECHO [%TIME%] Extract complete.
pause
