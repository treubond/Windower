set userBinName="char1"
set shortcutPath="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Windower.lnk"
set proxyPath="C:\Users\mtoms\OneDrive\Documents\PolProxy.exe"

set currentScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
set siblingScriptPath = Join-Path -Path $currentScriptPath -ChildPath "launch.ps1"

if (Test-Path $siblingScriptPath) {
    powershell.exe -ArgumentList "-File `".\launch.ps1`" -UserBinName %userBinName% -ShortcutPath `"%shortcutPath%`" -ProxyPath `"%proxyPath%`""
} else {
    Write-Host "Sibling script not found: $siblingScriptPath"
}