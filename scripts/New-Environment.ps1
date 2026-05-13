param(
    [Parameter(Mandatory = $true)]
    [string]$NewEnvironmentName
)

$RepoRoot = Split-Path -Parent $PSScriptRoot
$Source = Join-Path $RepoRoot "envs\dev"
$Destination = Join-Path $RepoRoot "envs\$NewEnvironmentName"

if (Test-Path $Destination) {
    throw "Environment already exists: $Destination"
}

Copy-Item -Recurse -Path $Source -Destination $Destination

Get-ChildItem -Recurse -Path $Destination -File | ForEach-Object {
    (Get-Content $_.FullName) `
        -replace "environment\s*=\s*`"dev`"", "environment  = `"$NewEnvironmentName`"" `
        -replace "/dev/", "/$NewEnvironmentName/" `
        -replace "dev/", "$NewEnvironmentName/" `
        | Set-Content $_.FullName
}

Write-Host "Created environment: $NewEnvironmentName" -ForegroundColor Green
Write-Host "Review terraform.tfvars and backend.hcl files before applying." -ForegroundColor Yellow
