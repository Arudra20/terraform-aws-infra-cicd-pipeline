param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("dev", "stage", "prod")]
    [string]$Environment,

    [Parameter(Mandatory = $true)]
    [ValidateSet("00-backend", "01-network", "02-registry", "03-cluster", "04-node-groups", "05-irsa", "06-addons", "07-apps")]
    [string]$Layer,

    [Parameter(Mandatory = $true)]
    [ValidateSet("init", "fmt", "validate", "plan", "apply", "destroy")]
    [string]$Action,

    [switch]$AutoApprove
)

$RepoRoot = Split-Path -Parent $PSScriptRoot
$LayerPath = Join-Path $RepoRoot "envs\$Environment\$Layer"

if (!(Test-Path $LayerPath)) {
    throw "Layer path not found: $LayerPath"
}

Push-Location $LayerPath

try {
    Write-Host "Environment: $Environment" -ForegroundColor Cyan
    Write-Host "Layer:       $Layer" -ForegroundColor Cyan
    Write-Host "Path:        $LayerPath" -ForegroundColor Cyan

    if ($Action -eq "init") {
        if (Test-Path ".\backend.hcl") {
            terraform init -backend-config="backend.hcl"
        }
        else {
            terraform init
        }
    }

    if ($Action -eq "fmt") {
        terraform fmt -recursive
    }

    if ($Action -eq "validate") {
        terraform validate
    }

    if ($Action -eq "plan") {
        terraform init -backend-config="backend.hcl"
        terraform fmt -recursive
        terraform validate
        terraform plan -out "tfplan"
    }

    if ($Action -eq "apply") {
        terraform init -backend-config="backend.hcl"
        terraform fmt -recursive
        terraform validate
        terraform plan -out "tfplan"

        if ($AutoApprove) {
            terraform apply -auto-approve "tfplan"
        }
        else {
            terraform apply "tfplan"
        }
    }

    if ($Action -eq "destroy") {
        terraform init -backend-config="backend.hcl"

        if ($AutoApprove) {
            terraform destroy -auto-approve
        }
        else {
            terraform destroy
        }
    }
}
finally {
    Pop-Location
}
