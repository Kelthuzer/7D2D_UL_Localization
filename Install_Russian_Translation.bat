@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Undead Legacy Russian Translation Updater

rem Windows 7-11 compatible installer/updater.
rem ASCII-only console text is intentional for reliable Windows 7 cmd.exe support.

set "ULRU_URL=https://github.com/Kelthuzer/7D2D_UL_Localization/releases/latest/download/UndeadLegacy_Russian.zip"
set "ULRU_REL=Mods\UndeadLegacy\Config\Localization"
set "ULRU_ZIP=%TEMP%\UndeadLegacy_Russian_%RANDOM%_%RANDOM%.zip"
set "ULRU_TMP=%TEMP%\UndeadLegacy_Russian_%RANDOM%_%RANDOM%"
set "ULRU_PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
set "GAME_DIR="

echo ============================================================
echo  Undead Legacy - Russian Translation Installer / Updater
echo ============================================================
echo.

rem Optional first argument: full path to the 7 Days To Die folder.
if not "%~1"=="" call :TryGamePath "%~1"

rem If the BAT is already in the game directory, use it.
if not defined GAME_DIR call :TryGamePath "%~dp0"
if not defined GAME_DIR call :TryGamePath "%CD%"

rem Steam usually registers the exact installation path here.
if not defined GAME_DIR call :TryRegistry "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 251570"
if not defined GAME_DIR call :TryRegistry "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 251570"
if not defined GAME_DIR call :TryRegistry "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 251570"

rem Common Steam locations as a fallback.
if not defined GAME_DIR if not "%ProgramFiles(x86)%"=="" call :TryGamePath "%ProgramFiles(x86)%\Steam\steamapps\common\7 Days To Die"
if not defined GAME_DIR call :TryGamePath "%ProgramFiles%\Steam\steamapps\common\7 Days To Die"

if not defined GAME_DIR goto AskPath
goto GameFound

:AskPath
echo 7 Days To Die with Undead Legacy was not found automatically.
echo Paste the full game folder, for example:
echo D:\SteamLibrary\steamapps\common\7 Days To Die
echo.
set "USER_PATH="
set /p "USER_PATH=Game folder (or Q to quit): "
if /i "%USER_PATH%"=="Q" goto Cancelled
set "USER_PATH=%USER_PATH:"=%"
call :TryGamePath "%USER_PATH%"
if not defined GAME_DIR (
    echo.
    echo Undead Legacy was not found in that folder.
    echo Expected: Mods\UndeadLegacy\Config\Localization\English.txt
    echo.
    goto AskPath
)

:GameFound
echo Found game:
echo   %GAME_DIR%
echo.

set "TARGET_FILE=%GAME_DIR%\%ULRU_REL%\Russian.txt"
set "NEW_FILE=%ULRU_TMP%\Mods\UndeadLegacy\Config\Localization\Russian.txt"

if exist "%ULRU_ZIP%" del /q "%ULRU_ZIP%" >nul 2>&1
if exist "%ULRU_TMP%" rd /s /q "%ULRU_TMP%" >nul 2>&1
md "%ULRU_TMP%" >nul 2>&1
if errorlevel 1 goto TempError

echo Downloading latest translation...
set "ULRU_DOWNLOAD_OK=0"

rem Primary downloader: PowerShell 2.0+ WebClient. Force TLS 1.2 where available.
if exist "%ULRU_PS%" (
    "%ULRU_PS%" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; try { [Net.ServicePointManager]::SecurityProtocol = [Enum]::ToObject([Net.SecurityProtocolType],3072) } catch {}; $wc=New-Object Net.WebClient; $wc.Headers.Add('User-Agent','UndeadLegacy-Russian-Updater'); $wc.DownloadFile($env:ULRU_URL,$env:ULRU_ZIP)" >nul 2>&1
    if not errorlevel 1 if exist "%ULRU_ZIP%" set "ULRU_DOWNLOAD_OK=1"
)

rem Windows 10/11 normally have curl.exe. Also supports user-installed curl on Windows 7.
if "%ULRU_DOWNLOAD_OK%"=="0" (
    where curl.exe >nul 2>&1
    if not errorlevel 1 (
        curl.exe -L --fail --silent --show-error --retry 3 -A "UndeadLegacy-Russian-Updater" -o "%ULRU_ZIP%" "%ULRU_URL%" >nul 2>&1
        if not errorlevel 1 if exist "%ULRU_ZIP%" set "ULRU_DOWNLOAD_OK=1"
    )
)

rem Old-Windows fallbacks.
if "%ULRU_DOWNLOAD_OK%"=="0" (
    where certutil.exe >nul 2>&1
    if not errorlevel 1 (
        certutil.exe -urlcache -split -f "%ULRU_URL%" "%ULRU_ZIP%" >nul 2>&1
        if not errorlevel 1 if exist "%ULRU_ZIP%" set "ULRU_DOWNLOAD_OK=1"
    )
)

if "%ULRU_DOWNLOAD_OK%"=="0" (
    where bitsadmin.exe >nul 2>&1
    if not errorlevel 1 (
        bitsadmin.exe /transfer "ULRU_%RANDOM%" /download /priority normal "%ULRU_URL%" "%ULRU_ZIP%" >nul 2>&1
        if not errorlevel 1 if exist "%ULRU_ZIP%" set "ULRU_DOWNLOAD_OK=1"
    )
)

if "%ULRU_DOWNLOAD_OK%"=="0" goto DownloadError
for %%F in ("%ULRU_ZIP%") do if %%~zF LSS 1024 goto DownloadError

echo Extracting...
set "ULRU_EXTRACT_OK=0"

rem Modern Windows can extract with tar.exe.
where tar.exe >nul 2>&1
if not errorlevel 1 (
    tar.exe -xf "%ULRU_ZIP%" -C "%ULRU_TMP%" >nul 2>&1
    if not errorlevel 1 if exist "%NEW_FILE%" set "ULRU_EXTRACT_OK=1"
)

rem Windows 7 fallback: Explorer ZIP support through Shell.Application.
if "%ULRU_EXTRACT_OK%"=="0" if exist "%ULRU_PS%" (
    "%ULRU_PS%" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $sh=New-Object -ComObject Shell.Application; $z=$sh.NameSpace($env:ULRU_ZIP); $d=$sh.NameSpace($env:ULRU_TMP); if($z -eq $null -or $d -eq $null){exit 2}; $d.CopyHere($z.Items(),20); $f=Join-Path $env:ULRU_TMP 'Mods\UndeadLegacy\Config\Localization\Russian.txt'; $ok=$false; for($i=0;$i -lt 150;$i++){ if(Test-Path -LiteralPath $f){ $n=(Get-Item -LiteralPath $f).Length; if($n -gt 1024){$ok=$true;break} }; Start-Sleep -Milliseconds 100 }; if(-not $ok){exit 3}" >nul 2>&1
    if not errorlevel 1 if exist "%NEW_FILE%" set "ULRU_EXTRACT_OK=1"
)

if "%ULRU_EXTRACT_OK%"=="0" goto ExtractError

rem Keep one backup of the previously installed translation.
if exist "%TARGET_FILE%" copy /y "%TARGET_FILE%" "%TARGET_FILE%.bak" >nul 2>&1

copy /y "%NEW_FILE%" "%TARGET_FILE%" >nul 2>&1
if errorlevel 1 goto CopyError

fc /b "%NEW_FILE%" "%TARGET_FILE%" >nul 2>&1
if errorlevel 1 goto CopyError

echo.
echo SUCCESS.
echo Russian translation installed/updated:
echo   %TARGET_FILE%
if exist "%TARGET_FILE%.bak" echo Previous file backup: %TARGET_FILE%.bak
echo.
call :Cleanup
pause
exit /b 0

:TryGamePath
set "CANDIDATE=%~1"
if not defined CANDIDATE exit /b 0
for %%I in ("%CANDIDATE%") do set "CANDIDATE=%%~fI"
if exist "%CANDIDATE%\Mods\UndeadLegacy\Config\Localization\English.txt" set "GAME_DIR=%CANDIDATE%"
exit /b 0

:TryRegistry
for /f "tokens=2,*" %%A in ('reg query "%~1" /v InstallLocation 2^>nul ^| find /i "InstallLocation"') do call :TryGamePath "%%B"
exit /b 0

:DownloadError
echo.
echo ERROR: Could not download the latest release.
echo URL:
echo   %ULRU_URL%
echo.
echo On Windows 7, make sure TLS 1.2 and current root certificates are installed.
goto Failed

:ExtractError
echo.
echo ERROR: Downloaded ZIP could not be extracted.
goto Failed

:CopyError
echo.
echo ERROR: Could not write Russian.txt to the game folder.
echo Try running this BAT as Administrator.
goto Failed

:TempError
echo.
echo ERROR: Could not create a temporary folder.
goto Failed

:Cancelled
echo.
echo Cancelled.
call :Cleanup
pause
exit /b 1

:Failed
call :Cleanup
echo.
pause
exit /b 1

:Cleanup
if exist "%ULRU_ZIP%" del /q "%ULRU_ZIP%" >nul 2>&1
if exist "%ULRU_TMP%" rd /s /q "%ULRU_TMP%" >nul 2>&1
exit /b 0
