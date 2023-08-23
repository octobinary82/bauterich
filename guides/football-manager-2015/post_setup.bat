@ECHO OFF
setlocal enabledelayedexpansion

set /p SETUP_RUN_MESSAGE=

rem Faz o parsing da saída do run_setup.bat
for /f "tokens=1,2,3,4,5,6 delims=#" %%a in ('echo %SETUP_RUN_MESSAGE%') do (
    set success_result=%%a
    set param1=%%b
    set param2=%%c
)

set DRIVE_LETTER=%param1%

if "%success_result%" neq "true" (
    echo false#1#O setup não pôde ser executado: %param2%
    exit
)

rem -------------

move %param1%\Crack\* c:\agd\footballmanager2015\ /Y

if %errorlevel% neq 0 (
    echo false#2#Os arquivos do ativador não puderam ser movidos
    exit
)

echo true#null#null

endlocal