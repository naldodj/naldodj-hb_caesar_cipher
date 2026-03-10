@setlocal
    del .\log\*.* /S /Q
    call "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64
    F:\harbour_msvc\bin\win\msvc64\hbmk2 caesar_cipher.hbp -comp=msvc64
    if EXIST .\caesar_cipher.exe (
        cmd /c upx.exe .\caesar_cipher.exe
        certutil -hashfile .\caesar_cipher.exe SHA256 2>&1 | findstr /V "CertUtil" > caesar_cipher.sha256
    )
@endlocal
