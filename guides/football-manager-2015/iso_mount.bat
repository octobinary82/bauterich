@ECHO OFF
setlocal

rem O parâmetro (caminho pro .iso) deve ser sempre
rem passado entre aspas, devido à verificação:
rem if "%%b"==%ISO_PATH%
rem A verificação acima, assim, já pressupõe a
rem inclusão das aspas no caminho
rem e.g. ./iso_mount "<CAMINHO>"
set ISO_PATH=%1

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

rem Monta a imagem
%IMGDRIVECMD% -xi
%IMGDRIVECMD% -m "%ISO_PATH%" >nul

set FOUND_MOUNTED=0
for /f "tokens=2,3" %%a in ('"%IMGDRIVECMD%" -l') do (
	if "%%b"==%ISO_PATH% (
		set DRIVE_LETTER=%%a
		set FOUND_MOUNTED=1
	)
)

if %FOUND_MOUNTED% == 0 (
	echo false#2#A imagem não foi montada
    exit 0
)

echo true#%DRIVE_LETTER%

(endlocal & set DRIVE_LETTER=%DRIVE_LETTER%)
