
$ComputerDomain = (Get-WmiObject Win32_ComputerSystem).Domain
$DomainName = "your_domain"                                                                      

$i = 0
function authentication{

    if (($ComputerDomain -ne $DomainName) -and !($i -eq 3)) {

        $DomainUsername = Read-Host -Prompt "Enter your domain username : "
        $DomainPassword = Read-Host -AsSecureString "Enter your domain password : "
        $Credential = New-Object System.Management.Automation.PSCredential ($DomainUsername, $DomainPassword)
        # $Credential = Get-Credential
        Write-Host "PC connection to domain $DomainName..."

        
        try {
            Add-Computer -DomainName $DomainName -Credential $Credential -ErrorAction Stop
            Write-Host "Restart PC to finalize domain connection."
            Unregister-ScheduledTask -TaskName "setup" -Confirm:$false 
            Start-Sleep -Seconds  5
            Restart-Computer -Force
        }
        catch {
            Write-Host "Failed to add PC to domain. Please check your credentials and try again."
            Write-Host $_.Exception.Message
            $i++
            authentication
        }        
        
    }
    elseif ($i -eq 3) {
        Write-Host "To many tries!"
        break
    }
    else {
        
        Write-Host "The computer is already in the domain !"
    
    }

}

authentication






