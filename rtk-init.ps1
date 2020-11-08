param (
    [switch]$persist = $false # Keeps the PowerShell window open after it finishes executing the script
)

function Get-RtkContainerCount
{
    $parentFolder = (Get-Item $PSScriptRoot).Name.ToLower()
    $rtkContainers = docker container ls -f name="^/$($parentFolder)_(database|backup|server)_1$" | Measure-Object
    $rtkExitedContainers = docker container ls -f name="^/$($parentFolder)_(database|backup|server)_1$" -f "status=exited" | Measure-Object
    return $rtkContainers.Count - $rtkExitedContainers.Count
}

$rtkContainersCount = Get-RtkContainerCount

if ($rtkContainersCount -gt 0)
{
    Write-Warning "At least one RTK container is already running. Please stop all existing containers before starting new ones."
    Write-Host "`nPress Enter to exit..."
    Read-Host
    exit
}

Set-Location -Path $PSScriptRoot
Write-Host "Pruning obsolete build images..."
docker image prune --force --filter "label=prune=true"
docker-compose up -d --build --force-recreate
$rtkContainersCount = Get-RtkContainerCount

if ($rtkContainersCount -lt 2)
{
    Write-Warning "An error occurred while starting the RTK containers. Please refer to the error output above and try again after remediating the issue."
    Write-Host "`nPress Enter to exit..."
    Read-Host
    exit
}

Write-Host "Starting MySQL..."
Start-Sleep -Seconds 10 # MySQL is already starting on its own, but we need to stall for a few seconds before attempting a client connection.

Write-Host "Startup complete! You may now run the client to connect and play." -ForegroundColor Green

if ($persist)
{
    Write-Host "`nPress Enter to exit..."
    Read-Host
}
else
{
    Start-Sleep -Seconds 2
}
