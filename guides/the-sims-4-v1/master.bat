@echo off
setlocal

set SETUP_ABSOLUTE_EXECUTABLE_PATH=%1

%SETUP_ABSOLUTE_EXECUTABLE_PATH% /FORCECLOSEAPPLICATIONS /SILENT /DIR=c:\agd\thesims4v1 >nul 2>&1
if %errorlevel% neq 0 (
	echo false#1#O setup não pôde completar com êxito
	exit
)

echo true#null#null

endlocal