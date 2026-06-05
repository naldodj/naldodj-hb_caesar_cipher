@setlocal EnableExtensions DisableDelayedExpansion
@ECHO OFF
@REM caesar_cipher: Released to Public Domain.

@pushd "%~dp0" || (
   @ECHO [caesar_cipher] Could not enter mk directory.
   @endlocal & exit /b 1
)

@FOR /F "delims=" %%F IN ('dir /b /a:-d /on "*.bat"') DO (
   @IF /I NOT "%%~nxF"=="%~nx0" (
      @IF /I "%%~nF"=="go64_gate" (
         @ECHO.
         @ECHO [caesar_cipher] Skipping %%~nxF because the validation gate runs build and smoke checks itself.
      ) ELSE @IF /I "%%~nF"=="go64_zig_build" (
         @IF /I NOT "%HBCAESAR_CIPHER_ZIG_ENABLE%"=="1" (
            @ECHO.
            @ECHO [caesar_cipher] Skipping %%~nxF because HBCAESAR_CIPHER_ZIG_ENABLE is not 1.
         ) ELSE (
            @ECHO.
            @ECHO [caesar_cipher] Running %%~nxF
            @cmd /d /q /c "%%~fF"
            @IF ERRORLEVEL 1 (
               @ECHO.
               @ECHO [caesar_cipher] %%~nxF failed.
               @popd
               @endlocal & exit /b 1
            )
         )
      ) ELSE (
         @ECHO.
         @ECHO [caesar_cipher] Running %%~nxF
         @cmd /d /q /c "%%~fF"
         @IF ERRORLEVEL 1 (
            @ECHO.
            @ECHO [caesar_cipher] %%~nxF failed.
            @popd
            @endlocal & exit /b 1
         )
      )
   )
)
@ECHO.
@ECHO [caesar_cipher] All batch scripts completed.
@popd
@endlocal & exit /b 0
