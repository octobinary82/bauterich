@ECHO OFF
setlocal enabledelayedexpansion

set /p SETUP_RUN_MESSAGE=

rem Faz o parsing da saída do run_setup.bat
for /f "tokens=1,2,3,4,5,6 delims=#" %%a in ('echo %SETUP_RUN_MESSAGE%') do (
    set success_result=%%a
    set param1=%%b
    set param2=%%c
)

if "%success_result%" neq "true" (
    echo false#1#O setup não pôde ser executado: %param2%
    exit
)

set DRIVE_LETTER=%param1%

rem -------------

copy %DRIVE_LETTER%\Crack\* "c:\agd\footballmanager2015\Football Manager 2015" /Y >nul 2>&1

if %errorlevel% neq 0 (
    echo false#2#Os arquivos do ativador não puderam ser copiados
    exit
)

set IMGDRIVECMD_DIR=%cd%/

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set ARCHITECTURE=x64
) else if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set ARCHITECTURE=x86
) else if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    set ARCHITECTURE=ARM64
) else (
    echo false#1#Arquitetura do OS desconhecida
    exit 0
)

set IMGDRIVECMD=%IMGDRIVECMD_DIR%imgdrivecmd_%ARCHITECTURE%.exe

%IMGDRIVECMD% -xu

echo true#null#null

endlocal
