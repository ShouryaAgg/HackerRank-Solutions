@echo off
setlocal enabledelayedexpansion

:: Colors
set "GREEN=[32m"
set "YELLOW=[33m"
set "RED=[31m"
set "BLUE=[34m"
set "RESET=[0m"

echo %BLUE%-----------------------------------------%RESET%
echo %GREEN%   🚀 HackerRank Auto-Update Script %RESET%
echo %BLUE%-----------------------------------------%RESET%
echo.

:: Ask for problem name
set /p problem="Enter the Problem Name: "
echo Problem Entered: %problem%
echo.

:: Language
echo Select where you solved the problem:
echo [1] Python
echo [2] SQL
echo [3] Others
set /p choice="Enter choice number: "

if "%choice%"=="1" set folder=Python
if "%choice%"=="2" set folder=SQL
if "%choice%"=="3" set folder=Others

echo.

:: File name
set /p filename="Enter the file name with extension (example: solve.py or query.sql): "

if not exist "%filename%" (
    echo %RED%❌ Error: The file "%filename%" was NOT found.%RESET%
    pause
    exit /b
)

echo %GREEN%✔ File found. Proceeding...%RESET%
echo.

:: Create folder if missing
if not exist "%folder%" mkdir "%folder%"

copy "%filename%" "%folder%\%problem%.%filename:*.=%" >nul
echo %GREEN%✔ File copied to %folder% folder.%RESET%
echo.

:: =======================================
:: COMMIT LOCAL CHANGES BEFORE PULL
:: =======================================
echo %BLUE%📝 Staging local changes before pull...%RESET%
git add .

git commit -m "Auto-save local changes before pulling" >nul 2>&1

:: (If nothing to commit, ignore it)
echo %GREEN%✔ Local changes saved.%RESET%
echo.

:: =======================================
:: SAFE GIT PULL (rebased)
:: =======================================
echo %BLUE%🔄 Pulling latest changes from GitHub...%RESET%
git pull --rebase origin main

if errorlevel 1 (
    echo %RED%❌ Git Pull Failed. Resolve manually.%RESET%
    pause
    exit /b
)

echo %GREEN%✔ Repository updated.%RESET%
echo.

:: =======================================
:: FINAL COMMIT FOR PROBLEM
:: =======================================
echo %BLUE%📦 Committing solution...%RESET%
git add .
git commit -m "Added solution for %problem%" 

echo %GREEN%✔ Commit complete.%RESET%
echo.

:: =======================================
:: PUSH
:: =======================================
echo %BLUE%🚀 Pushing to GitHub...%RESET%
git push origin main

if errorlevel 1 (
    echo %RED%❌ Push Failed.%RESET%
    pause
    exit /b
)

echo.
echo %GREEN%🎉 Update Completed Successfully!%RESET%
echo %BLUE%-----------------------------------------%RESET%
pause
