@echo off
setlocal

if not exist "DebugDir" mkdir "DebugDir"

".\Vendor\premake\bin\premake5.exe" vs2026

if errorlevel 1 (
echo.
echo [ERROR] Premake failed!
) else (
echo.
echo [SUCCESS] Premake finished successfully.
)

pause
endlocal
