@ECHO OFF
setlocal enabledelayedexpansion

set SETUP_RELATIVE_PATH=%1

set /p ISO_MOUNT_MESSAGE=

rem Faz o parsing da saída do iso_mount.bat
for /f "tokens=1,2,3,4,5,6 delims=#" %%a in ('echo %ISO_MOUNT_MESSAGE%') do (
    set success_result=%%a
    set param1=%%b
    set param2=%%c
)

if "%success_result%" neq "true" (
    echo false#1#A imagem não foi montada: %param2%
    exit 0
)

set DRIVE_LETTER=%param1%
set WAIT_TICKS=0
set MAX_WAIT_TICKS=10

:CHECK_DEVICE
rem Use o comando DIR para verificar se o dispositivo está acessível
dir %DRIVE_LETTER% >nul 2>nul

rem Verifique o código de erro retornado pelo comando DIR
if %errorlevel% neq 0 (
    if !WAIT_TICKS! gtr !MAX_WAIT_TICKS! (
        echo false#2#O dispositivo não pôde ser iniciado
        exit 0
    )
    set /a WAIT_TICKS+=1
    ping -n 3 localhost >nul
    goto CHECK_DEVICE
)

%DRIVE_LETTER%%SETUP_RELATIVE_PATH% /FORCECLOSEAPPLICATIONS /SILENT /DIR=c:\agd\footballmanager2015 >nul 2>&1
if %errorlevel% neq 0 (
    echo false#3#O instalador não completou com êxito
    exit 0
)

echo true#%DRIVE_LETTER%#null

endlocal
