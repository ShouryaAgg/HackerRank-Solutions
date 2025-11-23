@echo off
setlocal enabledelayedexpansion

:: ================================
:: Colors
:: ================================
for /f "delims=" %%a in ('powershell ^(New-Object -ComObject WScript.Shell^).Popup^("color"^)') do set reset=
echo.
set "GREEN=[32m"
set "YELLOW=[33m"
set "RED=[31m"
set "BLUE=[34m"
set "RESET=[0m"

:: ================================
:: Start
:: ================================
echo %BLUE%----------------------------------------- %RESET%
echo %GREEN%   🚀 HackerRank Auto-Update Script %RESET%
echo %BLUE%----------------------------------------- %RESET%
echo.

:: ================================
:: Ask for problem name
:: ================================
set /p problem="Enter the Problem Name: "
echo Problem Entered: %problem%
echo.

:: ================================
:: Ask for language choice
:: ================================
echo Select where you solved the problem:
echo [1] Python
echo [2] SQL
echo [3] Others
set /p choice="Enter choice number: "

if "%choice%"=="1" set folder=Python
if "%choice%"=="2" set folder=SQL
if "%choice%"=="3" set folder=Others

echo.

:: ================================
:: Ask for file name
:: ================================
set /p filename="Enter the file name with extension (example: solve.py or query.sql): "

if not exist "%filename%" (
    echo %RED%❌ Error: The file "%filename%" was NOT found.%RESET%
    echo Make sure it exists in the current folder.
    pause
    exit /b 1
)

echo %GREEN%✔ File found. Proceeding...%RESET%
echo.

:: ================================
:: Ensure folder exists
:: ================================
if not exist "%folder%" (
    echo %YELLOW%⚠ Folder '%folder%' does not exist. Creating it...%RESET%
    mkdir "%folder%"
)

:: Copy file
copy "%filename%" "%folder%\%problem%.%filename:*.=%" >nul

echo %GREEN%✔ File copied to %folder% folder.%RESET%
echo.

:: ================================
:: Auto Git Pull (safe rebase)
:: ================================
echo %BLUE%🔄 Pulling latest changes from GitHub...%RESET%
git pull --rebase origin main

if errorlevel 1 (
    echo %RED%❌ Git Pull Failed! Please resolve manually.%RESET%
    pause
    exit /b 1
)

echo %GREEN%✔ Repository is up to date.%RESET%
echo.

:: ================================
:: Git Add + Commit
:: ================================
echo Adding files...
git add .

echo Committing changes...
git commit -m "Added solution for %problem%" 

if errorlevel 1 (
    echo %YELLOW%⚠ Nothing new to commit.%RESET%
)

:: ================================
:: Git Push
:: ================================
echo %BLUE%🚀 Pushing to GitHub...%RESET%
git push origin main

if errorlevel 1 (
    echo %RED%❌ Push Failed.%RESET%
    echo %YELLOW%Tip:%RESET% Run this manually:
    echo git pull --rebase origin main
    echo git push origin main
    pause
    exit /b 1
)

echo.
echo %GREEN%🎉 Update Completed Successfully!%RESET%
echo %BLUE%-----------------------------------------%RESET%
pause
