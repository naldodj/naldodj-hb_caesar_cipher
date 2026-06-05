@setlocal EnableExtensions DisableDelayedExpansion
@ECHO OFF
@REM caesar_cipher: Released to Public Domain.

@IF NOT DEFINED HBCAESAR_CIPHER_ZIG_ENABLE SET "HBCAESAR_CIPHER_ZIG_ENABLE=1"
@SET "HB_ROOT=%~dp0.."
@SET "HB_OUT_DIR=%HB_ROOT%\exe\win\zig"
@IF NOT EXIST "%HB_OUT_DIR%" MKDIR "%HB_OUT_DIR%"

@call "%~dp0tools\go64_zig_build.bat" "%~dp0" "%HB_ROOT%\hbp\caesar_cipher.hbp" "%HB_OUT_DIR%\caesar_cipher.exe" "caesar_cipher.exe"
@endlocal & exit /b %ERRORLEVEL%
