Write-Host "Checking required CLI tools..." -ForegroundColor Cyan

$tools = @("terraform", "aws", "kubectl", "helm", "git")

foreach ($tool in $tools) {
    $cmd = Get-Command $tool -ErrorAction SilentlyContinue
    if ($null -eq $cmd) {
        Write-Host "Missing: $tool" -ForegroundColor Red
    }
    else {
        Write-Host "Found: $tool -> $($cmd.Source)" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Checking AWS identity..." -ForegroundColor Cyan
aws sts get-caller-identity
