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

rem -------------

echo Movendo arquivos


rem -------------

echo true#null#null

endlocal