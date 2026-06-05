@setlocal EnableExtensions DisableDelayedExpansion
@ECHO OFF
@REM caesar_cipher: Released to Public Domain.

SET "HB_ROOT=%~dp0.."
SET "HB_OUT_DIR=%HB_ROOT%\exe\win\msvc64"
SET "HB_OUT=%HB_OUT_DIR%\caesar_cipher.exe"

ECHO [caesar_cipher] Validation gate started.

CALL "%~dp0go64_build.bat"
IF ERRORLEVEL 1 (
   ECHO [caesar_cipher] Executable build failed.
   endlocal & exit /b 1
)

IF NOT EXIST "%HB_OUT%" (
   ECHO [caesar_cipher] Missing executable: %HB_OUT%
   endlocal & exit /b 1
)

ECHO.
ECHO [caesar_cipher] Running help smoke test.
"%HB_OUT%" --help
IF ERRORLEVEL 1 (
   ECHO [caesar_cipher] Help smoke test failed.
   endlocal & exit /b 1
)

CALL "%~dp0go64_commit_check.bat"
IF ERRORLEVEL 1 (
   ECHO [caesar_cipher] Commit check failed.
   endlocal & exit /b 1
)

ECHO.
ECHO [caesar_cipher] VALIDATION: PASS
endlocal & exit /b 0
