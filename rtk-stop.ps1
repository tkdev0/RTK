param (
    [Parameter(Mandatory=$false)]
    [switch] $persist = $false, # Keeps the PowerShell window open after it finishes executing the script
    
    [Parameter(Mandatory=$false)]
    [switch] $rm = $false # Removes RTK containers after stopping them
)

Set-Location -Path $PSScriptRoot
Write-Host "Stopping RTK containers..."

$parentFolder = (Get-Item $PSScriptRoot).Name.ToLower()
$rtkDatabase = "$($parentFolder)_database_1"
$rtkBackup = "$($parentFolder)_backup_1"
$rtkServer = "$($parentFolder)_server_1"
docker stop $rtkDatabase $rtkBackup $rtkServer

if ($rm)
{
    Write-Host "Removing RTK containers..."
    docker rm $rtkDatabase $rtkBackup $rtkServer
}

Write-Host "Pruning obsolete build images..."
docker image prune --force --filter "label=prune=true"
Write-Host "Shutdown complete!" -ForegroundColor Green

if ($persist)
{
    Write-Host "`nPress Enter to exit..."
    Read-Host
}
else
{
    Start-Sleep -Seconds 2
}
