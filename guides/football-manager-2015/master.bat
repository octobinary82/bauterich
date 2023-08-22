@echo off
setlocal

set ISO_PATH=%1
set SETUP_EXECUTABLE_PATH=%2

echo %ISO_PATH%
echo %SETUP_EXECUTABLE_PATH%

iso_mount %ISO_PATH% | run_setup %SETUP_EXECUTABLE_PATH% | post_setup

endlocal