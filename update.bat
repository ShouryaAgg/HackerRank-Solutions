@echo off
title HackerRank Auto Update Script

:: ------------------------------
:: Step 1: Create folder structure
:: ------------------------------
if not exist Python mkdir Python
if not exist SQL mkdir SQL
if not exist Others mkdir Others

:: ------------------------------
:: Step 2: Ask user for problem name
:: ------------------------------
set /p problemName=Enter the Problem Name: 

echo Problem Entered: %problemName%
echo.

:: ------------------------------
:: Step 3: Ask for file location
:: ------------------------------
echo Select where you solved the problem:
echo [1] Python
echo [2] SQL
echo [3] Others
set /p choice=Enter choice number: 

if "%choice%"=="1" set folder=Python
if "%choice%"=="2" set folder=SQL
if "%choice%"=="3" set folder=Others

:: ------------------------------
:: Step 4: Ask for filename
:: ------------------------------
set /p fileName=Enter the file name with extension (example: mysolution.py or solve.sql): 

set fullPath=%folder%\%fileName%

:: ------------------------------
:: Step 5: Add comment to the file
:: Auto-detect file extension for proper comment style
:: ------------------------------

for %%a in ("%fileName%") do set ext=%%~xa

if "%ext%"==".py" (
    echo # Added Solution of %problemName% > "%fullPath%.tmp"
)
if "%ext%"==".sql" (
    echo -- Added Solution of %problemName% > "%fullPath%.tmp"
)
if "%ext%"==".txt" (
    echo Added Solution of %problemName% > "%fullPath%.tmp"
)
if "%ext%"==".cpp" (
    echo // Added Solution of %problemName% > "%fullPath%.tmp"
)

:: Append original content if file exists
if exist "%fullPath%" (
    type "%fullPath%" >> "%fullPath%.tmp"
)

:: Replace original file
move /y "%fullPath%.tmp" "%fullPath%" >nul

echo Comment added successfully!
echo.

:: ------------------------------
:: Step 6: Add update history log
:: ------------------------------
echo [%date% %time%] Updated: %problemName% >> update-log.txt

:: ------------------------------
:: Step 7: Git automation
:: ------------------------------
echo Adding files to Git...
git add .

echo.
echo Committing changes...
git commit -m "Added Solution of %problemName%"

echo.
echo Pushing to GitHub...
git push origin main

echo.
echo ------------------------------
echo Update Completed Successfully!
echo ------------------------------
pause
