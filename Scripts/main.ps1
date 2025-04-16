
$KeyPort = Read-Host -Prompt "What is the drive letter of the USB key?"
$KeyPort = $KeyPort.ToUpper()   
$KeyPath = $keyport +  ":\auto_set_up\setup.ps1"

$action = New-ScheduledTaskAction -Execute 'C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe' -Argument "-ExecutionPolicy Bypass -File $keyPath"
$trigger = New-ScheduledTaskTrigger -AtLogon
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "setup" -Description "You're not suppossed to read this..." -RunLevel Highest


$NewComputerName = Read-Host -Prompt "Type the new name : "
Write-Host "Change computer name to $NewComputerName..."
Rename-Computer -NewName $NewComputerName -Force



$Pdf24InstallerPath = $KeyPort + ":\auto_set_up\pdf24-creator-11.21.0-x64.exe."
Write-Host "Starting PDF24 installation"
Start-Process  -FilePath $Pdf24InstallerPath -ArgumentList " /VERYSILENT /NOUPDATE" 
Write-Host "PDF24 installation has been completed ! "


$ChromeInstallerPath = $KeyPort + ":\auto_set_up\ChromeSetup.exe"
Write-Host "Starting Chrome installation"
Start-Process -FilePath $ChromeInstallerPath -ArgumentList "/silent /install" -Wait
Write-Host "Chrome installation has been completed !"

$VLCInstallerPath = $KeyPort + ":\auto_set_up\vlc-3.0.21-win64.exe"
Write-Host "Starting VLC installation..."
Start-Process -FilePath $VLCInstallerPath -ArgumentList "/S" -Wait
Write-Host "Chrome installation has been completed !"

$EsetInstallerPath = $KeyPort + ":\auto_set_up\epi_win_live_installer.exe"
Write-Host "Starting ESET installation..."
Start-Process -FilePath $EsetInstallerPath -ArgumentList "/S /silent /install" -Wait
Write-Host "ESET installation has been completed !"

$HeliosInstallerPath = $KeyPort + ":\auto_set_up\HeliosERP-Client.msi"
Write-Host "Starting Helios installation..."
Start-Process -FilePath $HeliosInstallerPath -ArgumentList "/quiet" -Wait
Write-Host "Helios installation has been completed !"

$PluginHeliosInstallerPath = $Keyport + ":\auto_set_up\vcredist_x64 V8.0.61000.exe"
$Plugin2HeliosInstallerPath = $Keyport + ":\auto_set_up\vcredist_x86 V8.0.61001.exe"
Write-Host "Starting Helios Plugins installation..."
Start-Process -FilePath $PluginHeliosInstallerPath -ArgumentList "/q /r:n" -Wait 
Start-Process -FilePath $Plugin2HeliosInstallerPath -ArgumentList "/q /r:n"  -Wait 
Write-Host "Helios Plugins installation has been completed !"

$KeepassInstallerPath = $KeyPort + ":\auto_set_up\KeePass-2.57.1-Setup.exe"
Write-Host "Starting Keepass installation..."
Start-Process -FilePath $KeepassInstallerPath -ArgumentList "/VERYSILENT" -Wait
Write-Host "Keepass installation has been completed"

Start-Sleep -Seconds  60

Restart-Computer -Force